class Cymbal
  include Ripple::Document

  property :model, String
  property :slug, String
  property :brand, String
  property :size, Float
  property :color, String
  property :material, String
  property :videos_added_at, Time
  key_on :slug
  timestamps!

  many :videos

  validates_presence_of :model
  validates_presence_of :brand

  before_save :save_slug

  def video_ids
    self.videos.map {|v| v.key}
  end

  def thumbnail
    "cymbals/#{self.slug}.jpg"
  end

  def has_new?
    if self.videos_added_at && Time.now - self.videos_added_at < 3.days
      true
    else
      false
    end
  end

private

  def save_slug
    self.slug = self.model.tr(' ' , '_').downcase
  end
end
