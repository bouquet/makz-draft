class User
  include Ripple::Document

  property :provider, String
  property :uid, String
  property :name, String

  key_on :uid

  def self.create_with_omniauth(auth)
    create! do |u|
      u.provider = auth["provider"]
      u.uid = auth["uid"]
      u.name = auth["user_info"]["name"]
    end
  end
end
