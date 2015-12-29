require 'nokogiri'
require 'watir-webdriver'
require 'csv'

browser = Watir::Browser.new
output = Hash.new
t = Time.new
zipsandurls = {
  "20001" => "http://www.homedepot.com/p/Philips-65W-Equivalent-Soft-White-BR40-Dimmable-with-Warm-Glow-Light-Effect-LED-Light-Bulb-E-457002/206357794",
  "21215" => "http://m.homedepot.com/p/Philips-65W-Equivalent-Soft-White-BR30-Dimmable-LED-Warm-Glow-Effect-Light-Bulb-E-457069/206341869"
              }

zipsandurls.each do |x, y|
  browser.goto "#{y}"
        z = "#{browser.html}"
  nokogiri_object = Nokogiri::HTML(z)
  prices = nokogiri_object.xpath("//div/span[@class='bold jumbo pip-price']")
  if prices == ""
    prices = "No Value Found"
  end
  output.merge!(x=>prices.to_s.delete("^$0-9."))
end

puts output
CSV.open("#{t}.csv", "wb") {|csv| output.to_a.each {|elem| csv << elem} }

at_exit do
  browser.close
end