module ApplicationHelper
  def asset_url
    if Rails.env == "production"
      "/static"
    else
      ""
    end
  end
end
