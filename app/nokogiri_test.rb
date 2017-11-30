require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'

url = "https://www.imyanmarhouse.com/search/for-sale/all-region/all-township"
doc = Nokogiri::HTML(open(url, :allow_redirections => :safe))
puts doc.at_css("title").text
i = 0
doc.css(".featured").each do |f|
  i = i + 1
  title = f.at_css(".word-break").text
  # price = f.at_css(".PriceCompare .BodyS, .PriceXLBold").text[/\$[0-9\.]+/]
  # puts "#{title} - #{price}"
  puts "#{title}"
  puts '-------'
  # puts item.at_css(".prodLink")[:href]
end
puts "----------#{i}"