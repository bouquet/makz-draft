class ArtistsController < ApplicationController
  layout :manage
  before_filter :authenticate, :except => [:index, :show]
  before_filter :join_birth, :only => [:create, :update]
  before_filter :video_ids, :only => [:new, :edit]

  def index
    @artists = Artist.all.sort {|a, b| a.name <=> b.name}

    respond_to do |format|
      format.html
      format.xml { render :xml => @artists }
    end
  end

  def show
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html
      format.xml { render :xml => @artist }
    end
  end

  def new
    @artist = Artist.new
  end

  def edit
    @artist = Artist.find(params[:id])
    session[:original_artist_name] = @artist.name
  end

  def create
    @artist = Artist.new(params[:artist])
    respond_to do |format|
      if @artist.save
        format.html { redirect_to(@artist, :notice => 'Artist added.') }
        format.xml { render :xml => @artist, :status => :created, :location => @artist }
      else
        format.html {render :action => "new", :layout => "manage"}
        format.xml { render :xml => @artist.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @artist = Artist.find(params[:id])
    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        Artist.find(session[:original_artist_name]).destroy if @artist.name != session[:original_artist_name]
        @artist.videos.each {|v| v.artists << @artist; v.save}
        format.html { redirect_to(@artist, :notice => 'Artist updated.') }
        format.xml { render :xml => @artist, :status => :created, :location => @artist }
      else
        format.html {render :action => "new", :layout => "manage"}
        format.xml { render :xml => @artist.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to(manage_url) }
      format.xml  { head :ok }
    end
  end

  def destroy_multi
    @artists = Artist.find(params[:artist_keys])
    @artists.each do |a|
      a.destroy
    end

    respond_to do |format|
      format.html { redirect_to(manage_url) }
      format.xml { head :ok }
    end
  end

private

  def join_birth
    params[:artist][:birth] = Time.new(
      params[:artist]['birth(1i)'].to_i,
      params[:artist]['birth(2i)'].to_i,
      params[:artist]['birth(3i)'].to_i
    )
    ['birth(1i)', 'birth(2i)', 'birth(3i)'].each {|i| params[:artist].delete(i)}
    params[:artist][:videos].delete_if {|v| v == nil || v == ""}
    params[:artist][:videos] = Video.find(params[:artist][:videos])
  end

  def video_ids
    @video_ids = Video.all.map {|v| v.key}
  end

  def artist_video_association
    Video.find(params[:artist][:videos]).each {|v| v.artists << @artist} if params[:artist][:videos]
  end
end
