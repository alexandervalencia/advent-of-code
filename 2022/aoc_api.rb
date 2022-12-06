require "httparty"
require "nokogiri"
require "reverse_markdown"

class AocApi
  include HTTParty
  base_uri "https://adventofcode.com"

  COOKIE = File.read(File.join(__dir__, "cookie.txt")).freeze

  def initialize(day)
    @options = {
      headers: {
        "Cookie" => "session=#{COOKIE}"
      },
      follow_redirects: false
    }
    @day = day.gsub(/^0/, "")
  end

  def download_instructions
    resp = self.class.get(puzzle_path, @options)
    doc = Nokogiri.HTML(resp.body)
    articles = doc.css("article.day-desc")
    articles.map { |article| ReverseMarkdown.convert(article.to_s) }.join("\n")
  end

  def download_input
    self.class.get(input_path, @options)
  end

  private

  def puzzle_path
    "/2022/day/#{@day}"
  end

  def input_path
    "#{puzzle_path}/input"
  end
end
