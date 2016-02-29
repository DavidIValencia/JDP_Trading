require 'nokogiri'
require 'watir-webdriver'
require 'webdriver-user-agent'
require 'csv'
load './stores2.rb'
load './products.rb'

b = Watir::Browser.new
output = Hash.new
t = Time.new
stores = S #stores.rb array
products = P #products.rb array


stores.each do |x|
  begin
  b.goto "https://www.google.com/search?lsf=seller:8740,store:2221886705553283364&tbm=shop&q=Philips+Lightbulbs+SlimStyle+40W+Equivalent+Soft+White&sa=X&ved=0ahUKEwi5r8H664LKAhVQxWMKHZE5CeAQljAIEQ&biw=772&bih=724"
  change_store = b.link :text => 'Change store'
  change_store.exists?
  change_store.click
  store_text = b.text_field :class => '_pWb jfk-textinput'
  store_text.exists? == true
  store_text.set "#{x}"
  find_stores = b.input(:class => 'jfk-button jfk-button-standard')
  find_stores.exists?
  find_stores.click
  sleep 1
  click_stores = b.link(:class => '_Muc jfk-button jfk-button-standard')
  click_stores.exists?
  click_stores.click
  sleep 1
  products.each do |y|
    begin
    product_text = b.text_field :class => '_fGf'
    product_text.exists?
    product_text.set "#{y}"
    product_btn = b.button :id => '_dGf'
    product_btn.exists?
    product_btn.click
        z = "#{b.html}"
    nokogiri_object = Nokogiri::HTML(z)
    prices = nokogiri_object.xpath("//div[@class='shop-result-group _G2d']/div[@class='product-results']/descendant::div[1]/*[1]/div/div/div/div/span[@class='_q4c']")
    output.merge!("#{x} #{y}" => prices.to_s.gsub("</b></span>","").gsub('<span class="_q4c"><b>',""))
    rescue
      puts "Error with #{product}"
    next
    end
  end
  rescue
    puts "Error with #{store}"
    next
  end
end

puts output
CSV.open("../../../Dropbox/JDP_Trading/#{t}.csv", "wb") {|csv| output.to_a.each {|elem| csv << elem} }

at_exit do
  b.close
end