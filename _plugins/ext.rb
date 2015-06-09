require 'jekyll-assets'
require 'uglifier'

## custom tag to replace new lines with a space (instead of strip_newline)
module ReplaceNewlineWithSpace
  def replace_newline_with_space(input)
    input.gsub!(/[\n]+/, ' ')
  end
end

Liquid::Template.register_filter(ReplaceNewlineWithSpace)

## custom tag to strip stop words from posts.json (search index)
module StripStopWords
  def strip_stop_words(input)
    stop_words = []
    File.open('stopwords.txt', 'r') do |f|
      f.each_line do |line|
        stop_words << line.gsub!(/[\n]+/, '').to_s
      end
    end

    for word in stop_words
      input = input.gsub(/\b#{word}\b+/, '')
    end
    input.gsub('   ', ' ').gsub('  ', ' ')
  end
end

Liquid::Template.register_filter(StripStopWords)

## custom emoji
require 'jemoji'
module Emoji
  emoji = Emoji.create('ello') do |char|
    char.add_tag 'ello'
  end
end
