class Lyricly
  require "text/hyphen"
  require "./english_number_method.rb"
  attr_accessor :source, :verses, :lyrics
  
  def initialize source
    @source = source
    @tempfile = "tempfile"
    @lyrics = File.open(@source, "r") { |file| file.read }.split(/\n\n/)
  end

  def make_key string
    string = string.split
    number = string.select { |item| item if item.match(/\d/) }
    string[string.index(number[0])] = englishNumber(number[0].to_i)
    string[0] = string[0].downcase
    string[1] = string[1].capitalize if string[0]
    symbol = string.join.to_sym
  end

  def versify
    @verses = {}
    @lyrics.each do |verse|
      verse_array = verse.split(/\n/)
      @verses[make_key(verse_array.reverse.pop)] = verse_array[1..verse_array.count-1].join("\n")
    end
    @verses
  end

  def explode! verses
    verses.each_key do |key|
      words = verses[key].split
      hyph_words = words.map! do |word|
        hyph = Text::Hyphen.new(:language => "de", :left => 0, :right => 0)
        .visualize(word, " -- ")
      end
      verses[key] = hyph_words.join(" ")
    end
  end

  def export content, destination="tempfile"
    File.open(destination, "w") do |file|
        if content.is_a?(Hash) && !content.empty?
          content.each_key do |key|
            file.puts "#{key} = \lyricmode {"
            file.puts "#{@verses[key]} }\n\n"
          end
        end
    end
  end
end

# newfile = Versify.new source
# puts verses = newfile.versify
# puts newfile.explode!(verses)
# newfile.export(verses)