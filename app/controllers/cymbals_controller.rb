class CymbalsController < ApplicationController
  layout :manage
  before_filter :authenticate, :except => [:index, :show]
  before_filter :clean, :only => [:create, :update]
  before_filter :video_ids, :only => [:new, :edit]

  def index
    @cymbals = Cymbal.all.sort {|a, b| a.model <=> b.model}

    respond_to do |format|
      format.html
      format.xml { render :xml => @cymbals }
    end
  end

  def show
    @cymbal = Cymbal.find(params[:id])

    respond_to do |format|
      format.html
      format.xml { render :xml => @cymbal }
    end
  end

  def new
    @cymbal = Cymbal.new
  end

  def edit
    @cymbal = Cymbal.find(params[:id])
    session[:original_cymbal_model] = @cymbal.model
  end

  def create
    @cymbal = Cymbal.new(params[:cymbal])
    respond_to do |format|
      if @cymbal.save
        format.html { redirect_to(@cymbal, :notice => 'Cymbal added.') }
        format.xml { render :xml => @cymbal, :status => :created, :location => @cymbal }
      else
        format.html {render :action => "new", :layout => "manage"}
        format.xml { render :xml => @cymbal.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @cymbal = Cymbal.find(params[:id])
    respond_to do |format|
      if @cymbal.update_attributes(params[:cymbal])
        Cymbal.find(session[:original_cymbal_model]).destroy if @cymbal.model != session[:original_cymbal_model]
        @cymbal.videos.each {|v| v.cymbals << @cymbal; v.save}
        format.html { redirect_to(@cymbal, :notice => 'Cymbal updated.') }
        format.xml { render :xml => @cymbal, :status => :created, :location => @cymbal }
      else
        format.html {render :action => "new", :layout => "manage"}
        format.xml { render :xml => @cymbal.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @cymbal = Cymbal.find(params[:id])
    @cymbal.destroy

    respond_to do |format|
      format.html { redirect_to(manage_url) }
      format.xml  { head :ok }
    end
  end

  def destroy_multi
    @cymbals = Cymbal.find(params[:cymbal_keys])
    @cymbals.each do |a|
      a.destroy
    end

    respond_to do |format|
      format.html { redirect_to(manage_url) }
      format.xml { head :ok }
    end
  end

private
  def video_ids
    @video_ids = Video.all.map {|v| v.key}
  end

  def clean
    params[:cymbal][:videos].delete_if {|v| v == nil || v == ""}
    params[:cymbal][:videos] = Video.find(params[:cymbal][:videos])
  end

  def cymbal_video_association
    Video.find(params[:cymbal][:videos]).each {|v| v.cymbals << @cymbal} if params[:cymbal][:videos]
  end
end
