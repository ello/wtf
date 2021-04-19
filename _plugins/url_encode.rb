# _plugins/url_encode.rb
require 'liquid'
require 'uri'

# Percent encoding for URI conforming to RFC 3986.
# Ref: http://tools.ietf.org/html/rfc3986#page-12
module URLEncoding
  def url_encode(url)
    # `URI::escape` and `URI::encode` are now deprecated, so we need to use
    # `URI::encode_www_form_component`.
    URI.encode_www_form_component(url)
  end
end

Liquid::Template.register_filter(URLEncoding)
