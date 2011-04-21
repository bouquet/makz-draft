class ManageController < ApplicationController
  layout "manage"
  before_filter :authenticate

  def home
    @videos = Video.all
    @artists = Artist.all
    respond_to do |format|
      format.html
    end
  end
end
