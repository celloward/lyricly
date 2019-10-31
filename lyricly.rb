source = "gilderoy_lyrics"

class Versify
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

  def export
    File.open("tempfile", "w") do |file|
        if !@verses.empty?
          @verses.each_key do |key|
            file.puts "#{key} = \lyricmode {"
            file.puts "#{@verses[key]} }\n\n"
          end
        else
          file.puts @lyrics
        end
    end
  end
end

newfile = Versify.new source
newfile.versify
newfile.export




# erb_temp = ERB.new template

#Each verse is lines of text until a blank line (HASH)
#
    #for every line
        #if line is blank end the writing