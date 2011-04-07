class Video
  include Ripple::Document

  property :title, String
  property :video_token, String
  property :thumbnail, String

  validates_presence_of :title
  validates_presence_of :video_token
  validates_presence_of :thumbnail

  before_create :short_key
  before_save :youkusid

private

  def short_key
    self.key = rand(36**8).to_s(36)
  end

  def youkusid
    self.video_token = $~[:sid] if %r|http://v.youku.com/v_show/id_(?<sid>\w+).html| =~ self.video_token
    self.video_token = $~[:sid] if %r|http://player.youku.com/player.php/sid/(?<sid>\w+)/v.swf| =~ self.video_token
  end
end
