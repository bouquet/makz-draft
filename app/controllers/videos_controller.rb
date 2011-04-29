class VideosController < ApplicationController
  layout :manage
  before_filter :authenticate, :except => [:index, :show]
  before_filter :artist_ids, :only => [:new, :edit]
  before_filter :sanitize, :only => [:create, :update]
  # GET /videos
  # GET /videos.xml
  def index
    @videos = Video.all.sort {|a, b| a.created_at <=> b.created_at}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.xml
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  # POST /videos.xml
  def create
    @video = Video.new(params[:video])

    respond_to do |format|
      if @video.save
        @video.artists.each {|a| a.videos << @video; a.save}
        format.html { redirect_to(@video, :notice => 'Video was successfully created.') }
        format.xml  { render :xml => @video, :status => :created, :location => @video }
      else
        format.html { render :action => "new", :layout => "manage" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        @video.artists.each {|a| a.videos << @video; a.save}
        format.html { redirect_to(@video, :notice => 'Video was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => "manage" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.xml
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to(manage_url) }
      format.xml  { head :ok }
    end
  end

  def destroy_multi
    @videos = Video.find(params[:video_keys])
    @videos.each do |v|
      v.destroy
    end

    respond_to do |format|
      format.html { redirect_to(manage_url) }
      format.xml { head :ok }
    end
  end

private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "yozloy" && password == "0054444944"
    end
  end

  def artist_ids
    @artist_ids = Artist.all.map {|a| a.key}
  end

  def sanitize
    params[:video][:artists].delete_if {|a| a == nil || a == ""}
    params[:video][:artists] = Artist.find(params[:video][:artists])
  end
end
