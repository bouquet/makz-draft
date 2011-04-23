module VideosHelper
  def parsed_video_url(v)
    a = "http://www.flvcd.com/parse.php?kw=http://v.youku.com/v_show/id_#{v}&format=high"
    doc = Nokogiri::HTML(open(a))
    middle = nil
    doc.xpath(%Q|//a[@class='link']|).each do |e|
      middle = e['href']
    end
    rsp = Net::HTTP.get_response(URI.parse(middle))
    rsp.header["location"]
  end
end
