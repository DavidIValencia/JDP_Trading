require 'nokogiri'
require 'watir-webdriver'
require 'webdriver-user-agent'
require 'thread'
require 'csv'

load './stores.rb'
load './products.rb'

output = Hash.new
t = Time.new
stores = S #stores.rb array
products = P #products.rb array

started_at = Time.now
stores.each do |page|
  puts "page #{page}"
  archive_page = Nokogiri::HTML(open("http://www.mcsweeneys.net/articles/archives?page=#{page}"))
  all_links = archive_page.css(".singleColumn a").map{|e| e['href']}
  article_urls = all_links.reject{|url| url.match(/articles\/archives\?/)}
  work_q = Queue.new
  article_urls.each{|url| work_q << url}
  workers = (0...5).map do
    Thread.new do
      begin
        while article_url = work_q.pop(true)
          begin
            article = Nokogiri::HTML(open("http://www.mcsweeneys.net/#{article_url}"))
            article_body = article.css(".articleBody").text
            puts article_body.size
            ChatBot.add_seed_data!( article_body )
          rescue => e
            puts "problem on page #{page} with article #{article_url}"
            puts e.inspect
          end
        end
      rescue ThreadError
      end
    end
  end; "ok"
  workers.map(&:join); "ok"
  puts "ESTIMATED TIME REMAINING IN HOURS:"
  puts (((Time.now - started_at) / page) * (266 - page) / 3600.0).inspect
end