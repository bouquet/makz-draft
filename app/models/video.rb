class Video
  include Ripple::Document

  property :title, String
  property :video_token, String
  timestamps!

  validates_presence_of :title
  validates_presence_of :video_token

  many :artists

  before_create :short_key
#  before_save :youkusid

  def thumbnail
    "thumbnails/#{self.key}.jpg"
  end

private

  def short_key
    self.key = rand(36**8).to_s(36)
  end

#  def youkusid
#    self.video_token = $~[:sid] if %r|http://v.youku.com/v_show/id_(?<sid>\w+).html| =~ self.video_token
#    self.video_token = $~[:sid] if %r|http://player.youku.com/player.php/sid/(?<sid>\w+)/v.swf| =~ self.video_token
#  end
end
