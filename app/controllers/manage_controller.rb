class ManageController < ApplicationController
  def home
    @videos = Video.all
    respond_to do |format|
      format.html
    end
  end
end
