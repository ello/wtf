require "jekyll-assets"
require "uglifier"

## custom tag to replace new lines with a space (instead of strip_newline)
module ReplaceNewlineWithSpace
  def replace_newline_with_space(input)
    input.gsub!(/[\n]+/, " ")
  end
end

Liquid::Template.register_filter(ReplaceNewlineWithSpace)
