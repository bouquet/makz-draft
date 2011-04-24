module VideosHelper
  def getsid
    i1 = ((rand * 999).floor + 1000).to_s
    i2 = ((rand * 9000).floor + 1000).to_s
    (Time.now.to_f * 1000).floor.to_s << i1 << i2
  end

  def yvmeta(yvid)
    uri = URI.parse("http://v.youku.com/player/getPlayList/VideoIDS/#{yvid}/timezone/+08/version/5/source/video")
    rsp = Net::HTTP.get_response(uri)
    Yajl::Parser.parse(rsp.body, :symbolize_keys => true)[:data][0]
  end

  def fileidmix(seed)
    mixed = ""
    source = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/\\:._-1234567890"
    source.length.times do
      seed = (seed.to_f * 211 + 30031) % 65536
      index = (seed / 65536 * source.length).floor
      mixed << source[index]
      source.slice!(index)
    end
    mixed
  end

  def getfileid(fileid, seed)
    mixed = fileidmix(seed)
    ids = fileid.split(%r{\*})
    realid = ""
    ids.length.times do |i|
      idx = ids[i].to_i
      realid << mixed[idx]
    end
    realid
  end

  def genkey(key1, key2)
    key = key1.to_i(16)
    key ^= 0xA55AA5A5;
    key2 + key.to_s(16)
  end

  def ykmp4(ykid)
    aa = yvmeta(ykid)
    fileid = getfileid(aa[:streamfileids][:mp4], aa[:seed])
    key = genkey(aa[:key1], aa[:key2])
    middle = "http://f.youku.com/player/getFlvPath/sid/#{getsid}_00/st/mp4/fileid/#{fileid}?K=#{key}"
    rsp = Net::HTTP.get_response(URI.parse(middle))
    rsp.header["location"]
  end
end
