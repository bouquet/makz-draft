class ManageController < ApplicationController
  layout "manage"
  before_filter :authenticate

  def home
    @videos = Video.all.sort {|a, b| b.created_at <=> a.created_at}
    @artists = Artist.all.sort {|a, b| b.created_at <=> a.created_at}
    respond_to do |format|
      format.html
    end
  end
end
