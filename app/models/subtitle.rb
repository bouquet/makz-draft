class Subtitle
  include Ripple::EmbeddedDocument

  property :start, Float
  property :end, Float
  property :text, String
  timestamps!

  embedded_in :video

  validates_presence_of :start
  validates_presence_of :end
end
