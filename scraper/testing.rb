require 'nokogiri'
require 'watir-webdriver'
require 'webdriver-user-agent'
require 'csv'
require 'workers'
require 'thread'
load './stores.rb'
load './products.rb'

output = Hash.new
t = Time.new
started_at = Time.now
stores = S #stores.rb array
products = P #products.rb array

stores.each do |store|
          urls = Hash.new
          b = Watir::Browser.new
            b.goto "https://www.google.com/search?lsf=seller:8740,store:2221886705553283364&tbm=shop&q=Philips+Lightbulbs+SlimStyle+40W+Equivalent+Soft+White&sa=X&ved=0ahUKEwi5r8H664LKAhVQxWMKHZE5CeAQljAIEQ&biw=772&bih=724"
            change_store = b.link :text => 'Change store'
            if change_store.exists?
              change_store.click
            else
              sleep 45
              b.close
              puts "error with clicking change store link"
            next
            end
            store_text = b.text_field :class => '_pWb jfk-textinput'
            if store_text.exists?
              store_text.set "#{store}"
            else
              b.close
              puts "error with changing #{store}"
            next
            end
            find_stores = b.input(:class => 'jfk-button jfk-button-standard')
            if find_stores.exists?
              find_stores.click
            else
              b.close
            puts "error with clicking #{store}"
            next
            end
            sleep 3
            click_stores = b.link(:class => '_Muc jfk-button jfk-button-standard')
            if click_stores.exists?
              click_stores.click
            else
              b.close
              puts "error with clicking #{store}"
            next
            end
            sleep 3
          products.each do |product|
            puts "ESTIMATED TIME REMAINING IN HOURS:"
            puts (((1.0/((stores.index(store)+1.0)/(stores.length)) * (Time.now - started_at)-(Time.now - started_at))/3600.0)).inspect
            product_text = b.text_field :class => '_fGf'
            if product_text.exists?
              product_text.set "#{product}"
            else
              sleep 45
              b.goto "https://www.google.com/search?lsf=seller:8740,store:2221886705553283364&tbm=shop&q=Philips+Lightbulbs+SlimStyle+40W+Equivalent+Soft+White&sa=X&ved=0ahUKEwi5r8H664LKAhVQxWMKHZE5CeAQljAIEQ&biw=772&bih=724"
            change_store = b.link :text => 'Change store'
            if change_store.exists?
              change_store.click
            else
              sleep 45
              b.close
              puts "error with clicking change store link"
            next
            end
            store_text = b.text_field :class => '_pWb jfk-textinput'
            if store_text.exists?
              store_text.set "#{store}"
            else
              b.close
              puts "error with changing #{store}"
            next
            end
            find_stores = b.input(:class => 'jfk-button jfk-button-standard')
            if find_stores.exists?
              find_stores.click
            else
              b.close
            puts "error with clicking #{store}"
            next
            end
            sleep 3
            click_stores = b.link(:class => '_Muc jfk-button jfk-button-standard')
            if click_stores.exists?
              click_stores.click
            else
              b.close
              puts "error with clicking #{store}"
            next
            end
            sleep 3
              if product_text.exists?
                product_text.set "#{product}"
              else
                puts "error clicking #{product} text"
                b.close
              end
            end
            product_btn = b.button :id => '_dGf'
            if product_btn.exists?
              product_btn.click
            else
                puts "error clicking #{product} text button"
              next
            end
            u = "#{b.url}"
            urls.merge!("#{store} #{product}" => u)
            z = "#{b.html}"
            nokogiri_object = Nokogiri::HTML(z)
            prices = nokogiri_object.xpath("//div[@class='shop-result-group _G2d']/div[@class='product-results']/descendant::div[1]/*[1]/div/div/div/div/span[@class='_q4c']")
            output.merge!("#{store}~#{product}" => prices.to_s.gsub("</b></span>","").gsub('<span class="_q4c"><b>',""))
          end
        CSV.open("../../../Dropbox/JDP_Trading/#{store}_urls.csv", "wb") {|csv| urls.to_a.each {|elem| csv << elem} }
        CSV.open("../../../Dropbox/JDP_Trading/#{store}_run_at_#{t}.csv", "wb") {|csv| output.to_a.each {|elem| csv << elem} }
        b.close
    end





=begin
require 'watir-webdriver'

profile = Selenium::WebDriver::Firefox::Profile.new
profile.proxy = Selenium::WebDriver::Proxy.new :http => '124.244.76.175:80'
browser = Watir::Browser.new :ff, :profile => profile
=end
