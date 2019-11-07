require "./lib/lyricly.rb"

describe Lyricly do
  
  it "formats English document into Lilypond lyrics" do
    subject = Lyricly.new("source-english")
    verses = subject.versify
    subject.explode!(verses)
    subject.export(verses)
    expect(File.open("tempfile", "r") { |file| file.read }).to eql(File.open("test-english", "r") { |file| file.read })

  end

  it "formats German document into Lilypond lyrics" do
    subject = Lyricly.new("source-german")
    verses = subject.versify
    subject.explode!(verses)
    subject.export(verses)
    expect(File.open("tempfile", "r") { |file| file.read }).to eql(File.open("test-german", "r") { |file| file.read })
  end

  it "formats document into Lilypond markup" do
    subject = Lyricly.new("source-german")
    verses = subject.versify
    subject.markup(verses)
    subject.export(verses)
    expect(File.open("tempfile", "r") { |file| file.read }).to eql(File.open("test-markup", "r") { |file| file.read })
  end

  it "leaves out user-specified verses" do
  end

  it "ignores extra whitespace in source document" do
  end

  it "reads document with varying verse label lines" do
  end

  it "reads document with inline number for verse designation" do
  end

  it "formats Scots document into Lilypond lyrics" do
  end

end