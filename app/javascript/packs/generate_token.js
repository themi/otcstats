// setup by rails
//    var key_id = ENV.fetch('CLOUDFLARE_ACCOUNT_ID')
//    var video_id = stream.video_id
//    var private_key = ENV.fetch('CLOUDFLARE_STREAMING_PRIVATE_KEY_PEM')
//    var expires_in = '6h'


function generateSignedToken(kid, vid, pkey, expires) {
  const jwt = require('jsonwebtoken');

  var token = jwt.sign(
    {
      kid: kid,
      sub: vid,
    },
    Buffer.from(pkey,'base64'),
    {
      expiresIn: expires, // or preferred expiry time. Note that this should be longer than the duration of the video
      algorithm: 'RS256',
    }
  );

  // console.log(token)

  // you can now use the token instead of the video id when viewing videos
  return token;
};

$(document).on('turbolinks:load', function() {
  var element = $('input#signed_url_token');
  if (element != null) {
    element.val(generateSignedToken(key_id, video_id, private_key, expires_in));
  }
});

