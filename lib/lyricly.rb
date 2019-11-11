require "text/hyphen"
require "numbers_and_words"

class Lyricly
  attr_accessor :source, :verses, :lyrics
  
  def initialize source 
    @source = source
    @lyrics = File.open(@source, "r") { |file| file.read }.split(/\n\n/)
    @verses = versify(@lyrics)
  end

  def make_key string
    string = string.split
    number = string.select { |item| item if item.match(/\d/) }
    string[string.index(number[0])] = number[0].to_i.to_words
    if string[0]
      string[0] = string[0].downcase
      string[1] = string[1].capitalize
    end
    symbol = string.join.to_sym
  end

  def versify lyrics
    verses = {}
    lyrics.each do |verse|
      line = verse.split(/\n/)
      verses[make_key(line.reverse.pop)] = line[1..line.count-1].join("\n")
    end
    verses
  end

  def explode text
    text.each_key do |key|
      words = text[key].split
      hyph_words = words.map! do |word|
        hyph = Text::Hyphen.new(:language => "en_us", :left => 1, :right => 1)
        .visualize(word, " -- ")
      end
      text[key] = hyph_words.join(" ")
    end
  end

  def format_inline verses
    if @verses.is_a?(Hash) && !@verses.empty?
      @verses.each_key do |key|
        file.puts "#{key} = \lyricmode {"
        file.puts "#{@verses[key]} }\n\n"
      end
    end
  end

  def export destination="tempfile"
    File.open(destination, "w") do |file|
      hyph_verses = explode(verses) 
      format_inline(hyph_verses)
    end
  end
end

# newfile = Lyricly.new("../spec/source-english")
# newfile.export