function fileidmix(seed) {
  var mixed = "";
  var source = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/\\:._-1234567890";
  var len = source.length;
  for (i = 0; i < len; i++) {
    seed = (seed * 211 + 30031) % 65536;
    var index = Math.floor(seed / 65536 * source.length);
    mixed = mixed + source[index];
    source = source.substring(0, index) + '' + source.substring(index+1);
  };
  return mixed
};

function getfileid(fileid, seed) {
  var mixed = fileidmix(seed);
  var ids = fileid.split('*');
  var realid = "";
  var len = ids.length;
  for (i = 0; i < len; i++) {
    var idx = ids[i] * 1;
    realid = realid + mixed[idx];
  };
  return realid
};

function getsid() {
  i1 = Math.floor(Math.random()*999) + 1000;
  i2 = Math.floor(Math.random()*9000) + 1000;
  var _time = new Date();
  return _time.getTime() + "" + i1 + "" + i2
};

function genkey(key1, key2) {
  var key = parseInt(key1, 16);
  key = key ^ 0xA55AA5A5;
  return key2 + key.toString(16);
};

function ykmp4(fid, seed, key1, key2) {
  var fileid = getfileid(fid, seed);
  var key = genkey(key1, key2);
  middle = "http://f.youku.com/player/getFlvPath/sid/" + getsid() + "_00/st/mp4/fileid/" + fileid + "?K=" + key;
  return middle;
};
