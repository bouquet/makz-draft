class SubtitlesController < ApplicationController
  layout "manage"
  def index
    @video = Video.find(params[:video_id])
    @subtitles = @video.subtitles.empty? ? @video.subtitles : [] << @video.subtitles.build

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subtitles }
    end
  end

  #def new
  #  @subtitle = Subtitle.new

  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.xml  { render :xml => @subtitle }
  #  end
  #end

  #def edit
  #  @subtitle = Subtitle.find(params[:id])
  #end

  def create
    @subtitle = Subtitle.new(params[:subtitle])

    respond_to do |format|
      if @subtitle.save
        format.html { redirect_to(@subtitle, :notice => 'Subtitle was successfully created.') }
        format.xml  { render :xml => @subtitle, :status => :created, :location => @subtitle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subtitle.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @subtitle = Subtitle.find(params[:id])

    respond_to do |format|
      if @subtitle.update_attributes(params[:subtitle])
        format.html { redirect_to(@subtitle, :notice => 'Subtitle was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subtitle.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @subtitle = Subtitle.find(params[:id])
    @subtitle.destroy

    respond_to do |format|
      format.html { redirect_to(subtitles_url) }
      format.xml  { head :ok }
    end
  end
end
