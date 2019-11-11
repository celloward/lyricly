require "./lib/lyricly.rb"

describe Lyricly do

  def external_test testfile
    (File.open("tempfile", "r") { |file| file.read }) == (File.open("test-docs/#{testfile}", "r") { |file| file.read })
  end

  it "formats English document into Lilypond lyrics" do
    subject = Lyricly.new("source-docs/source-english", "-l")
    expect(external_test("test-english-hyph")).to eql(true)
  end

  it "formats German document into Lilypond lyrics" do
    subject = Lyricly.new("source-docs/source-german", "-l")
    expect(external_test("test-german-hyph")).to eql(true)
  end

  it "formats document into Lilypond markup" do
    subject = Lyricly.new("source-docs/source-german", "-m")
    expect(external_test("test-markup")).to eql(true)
  end

  it "leaves out user-specified verses" do
    subject = Lyricly.new("source-docs/source-german", "-l", [1, 10])
    expect(external_test("test-excerpt")).to eql(true)
  end

  it "ignores extra whitespace in source document" do
    subject = Lyricly.new("source-docs/source-messy", "-l")
    expect(external_test("test-english-hyph")).to eql(true)
  end

  it "reads document with varying verse label lines" do
    subject = Lyricly.new("source-docs/ource-diverse", "-l")
    expect(external_test("test-german-hyph")).to eql(true)
  end

  it "reads document with inline number for verse designation" do
    subject = Lyricly.new("source-docs/source-inline", "-l")
    expect(external_test("test-german-hyph")).to eql(true)
  end

  # it "formats Scots document into Lilypond lyrics" do
  # end

end