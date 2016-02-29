require 'nokogiri'
require 'watir-webdriver'
require 'csv'


t = Time.new
stores = [
  "650 Stillwater Ave, Bangor",
  "2435 Lafayette St, Santa Clara",
  "Bennington VT",
  "Rhode Island Ave Washington DC",
  "Ellicott City MD",
  "Catonsville MD",
  "W Little Rock AR",
  "Conway AR",
  "Ellsworth ME",
  "West Mifflin PA",
  "Ross Township PA",
  " 3550 William Penn Highway, PA Wilkins",
  "Sioux Falls",
  "Iron Mountain MI",
  "Cicero IL",
  "Evanston IL",
  "Las Cruces NM",
  "7545 N Mesa Street, El Paso 79912",
  "East El Paso TX",
  "Roosevelt Blvd Philadelphia, PA 19124",
  "2539 Castor Avenue, Philadelphia, PA, 19134",
  "1350 Macarthur Road, Whitehall, PA 18052",
  "Dickson City PA",
  "615 Arsenal Street, Watertown, MA, 02472",
  "Glastonbury, CT",
  "80 Buckland Hills Dr; Manchester, CT",
  "Chicopee MA",
  "179 Dagget Drive, West Springfield, MA",
  "350 Russell Street Hadley",
  "759 Harvest Ln, Williston",
  "245 Riverside St, Portland, ME 04103",
  "154 Topsham Fair Mall Rd, Topsham",
  "346 Middle Country Rd, Coram",
  "555 Hubbard Ave-Unit 21, Pittsfield",
  "65 Independence Dr, Hyannis",
  "387 Charles St, Providence",
  "350 Barnum Ave Cutoff, Stratford",
  "2905 E Market Street, York",
  "51 N Mccain Drive, Frederick",
  "3301 E West Highway, Hyattsville",
  "4700 Cherry Hill Rd, College Park",
  "1621 N Olden Avenue, Ewing",
  "399-443 Springfield Ave, Newark",
  "400 N Highland Ave, Pittsburgh",
  "9971 Mountain View Dr, West Mifflin",
  "100 South Grener Rd, Columbus",
  "1680 Stringtown Road, Grove City",
  "100 Cross Terrace Blvd, Charleston",
  "3051 West Radio Drive, Florence",
  "2031 Walnut Street, Cary, NC, 27518",
  "650 Ponce De Leon, Atlanta",
  "855 Lane Ave South, Jacksonville",
  "6325 I-55 North, Jackson",
  "1627 Poplar Avenue, Memphis",
  "12300 I-10 Service Rd, New Orleans",
  "1100 S Claiborne Ave, New Orleans, Louisiana, 70125",
  "6900 Pines Road, Shreveport",
  "2225 N Post Road, Indianapolis",
  "9320 Corporation Dr, Indianapolis, IN 46256",
  "18700 Meyers Road; Detroit, MI 48235",
  "3300 Carpenter Rd, Ypsilanti",
  "W8141 Highway Us 2, Iron Mountain",
  "3202 S Kings Hwy Blvd, Saint Louis",
  "1520 New Brighton Blvd, Minneapolis",
  "4900 Se 14th St, Des Moines",
  "415 Cunningham Drive, Sioux City",
  "2523 S Louise Ave, Sioux Falls",
  "12610 Chenal Pkwy, Little Rock",
  "507 West 19th Street, El Dorado",
  "500 Elsinger Blvd, Conway",
  "4900 East 2nd Street, Casper",
  "1925 Foothill Blvd, Rock Springs",
  "1740 Fleischli Pkwy, Cheyenne",
  "3870 Quebec Street, Denver",
  "2436 F Road, Grand Junction",
  "1200 Milwaukee Street, Boise",
  "937 N Westridge Drive, Saint George, UT, 84770",
  "7345 Delridge Way SW Seattle, WA 98106",
  "2701 Utah Ave South, Seattle",
  "2601 Bickford Avenue, Snohomish",
  "420 Telegraph Rd, Bellingham",
  "10120 Se Washington St, Portland",
  "2115 S First Street, Yakima",
  "520 Us Highway 101 North, Crescent City",
  "3272 W Shaw Avenue, Fresno",
  "1781 E Bayshore Rd, East Palo Alto",
  "27952 Hillcrest, Mission Viejo, CA, 92692",
  "4750 S Decatur Blvd, Las Vegas",
  "5125 Summit Ridge Ct, Reno",
  "2650 W Thunderbird Rd, Phoenix",
  "2820 Coors Blvd Nw, Albuquerque",
  "1200 Barbara Jordan Blvd, Suite 100, Austin",
  "4041 S Sheridan, Tulsa",
  "Park City UT",
  "1461 Meadowview Road, CA 95832",
  "8000 Folsom Blvd, Sacramento",
  "3398 S Highland Drive, Salt Lake City, Utah 84106",
  "6400 Alondra Blvd Paramount, CA",
  "355 Marketplace Ave San Diego, CA 92113",
  "12185 Carmel Mountain Rd, San Diego, CA 92128",
  "1550 W Valley Parkway, Escondido, California 92029",
  "86004 AZ"
  ]

products = [
  "Philips Lightbulbs SlimStyle 40W Equivalent Soft White",
  "Philips Lightbulbs SlimStyle 40W Equivalent Daylight (5000K) A19",
  "75W Equivalent Daylight A19 Dimmable LED Light Bulb",
  "75W Equivalent Soft White A19 Dimmable LED Light Bulb",
  "100W Equivalent Soft White (2700K) A21 Dimmable LED Light Bulb",
  "100W Equivalent Daylight (5000K) A21 Dimmable LED Light Bulb",
  "Cree Lightbulbs 100W Equivalent Daylight (5000K) A21 Dimmable LED Light Bulb BA21-16050OMF-12DE26-1U100",
  "00849665009788",
  "Cree Lightbulbs TW Series 40W Equivalent Soft White Candelabra Decorative Dimmable LED Light Bulb (3-Pack) BB13-03527OMC-12DE12-1C600",
  "Cree Lightbulbs 30/60/100W Equivalent Soft White (2700K) A21 3-Way LED Light Bulb BA21-16027OMF-12WE26-1U100",
  "Cree Lightbulbs 100W Equivalent Soft White (2700K) A21 Dimmable LED Light Bulb BA21-16027OMF-12DE26-1U100",
  "Cree Lightbulbs 75W Equivalent Daylight A19 Dimmable LED Light Bulb BA19-11050OMF-12DE26-1U100",
  "00810048029969",
  "Connected 60W Equivalent Daylight A19 Dimmable LED Light Bulb",
  "Cree Lightbulbs TW Series 25W Equivalent Soft White Candelabra Decorative Dimmable LED Light Bulb (3-Pack) BB13-02027OMC-12DE12-1C600",
  "Cree Lightbulbs 40W Equivalent Soft White A19 Dimmable LED Light Bulb with 4-Flow Filament Design BA19-04527OMB-12DE26-3_1",
  "Connected 60W Equivalent Soft White A19 Dimmable LED Light Bulb",
  "65W Equivalent Daylight BR40 Dimmable LED Flood Light Bulb",
  "65W Equivalent Soft White BR40 Dimmable LED Flood Light Bulb",
  "Cree Lightbulbs 75W Equivalent Soft White A19 Dimmable LED Light Bulb BA19-11027OMF-12DE26-1U100",
  "Cree Lightbulbs 60W Equivalent Soft White A19 Dimmable LED Light Bulb with 4-Flow Filament Design BA19-08027OMB-12DE26-3_1",
  "Cree Lightbulbs 65W Equivalent Daylight (5000K) BR30 Dimmable LED Flood Light BBR30-06550FLF-12DE26-4U100",
  "Cree Lightbulbs 40W Equivalent Daylight A19 Dimmable LED Light Bulb with 4-Flow Filament Design BA19-04550OMB-12DE26-3_1",
  "Cree Lightbulbs 6 in. TW Series 65W Equivalent Daylight (5000K) Dimmable LED Retrofit Recessed Downlight DRDL6-06250009-12DE26-1C100",
  "Cree Lightbulbs 6 in. TW Series 65W Equivalent Soft White (2700K) Dimmable LED Retrofit Recessed Downlight DRDL6-06227009-12DE26-1C100",
  "90W Equivalent Bright White PAR38 Dimmable LED 47° Flood Light Bulb",
  "90W Equivalent Bright White PAR38 Dimmable LED 27° Spot Light Bulb",
  "Philips Lightbulbs 60W Equivalent Daylight A19 LED Light Bulb 455955",
  "00046677455507",
  "Philips Lightbulbs SlimStyle 75W Equivalent Soft White A21 LED Light Bulb 452755",
  "Philips Lightbulbs 4 ft. T8 17-Watt Cool White Linear LED Light Bulb 456590",
  "Philips Lightbulbs 65W Equivalent Soft White BR30 Dimmable LED with Warm Glow Effect Light Bulb (E) 457069",
  "Philips Lightbulbs 4 ft. T8 14.5-Watt Daylight (5000K) Linear LED Light Bulb 453886",
  "00046677800000",
  "Philips Lightbulbs SlimStyle 60W Equivalent Daylight (5000K) A19 LED Light Bulb 452986",
  "Philips Lightbulbs SlimStyle 40W Equivalent Daylight (5000K) A19 Dimmable LED Light Bulb 433219",
  "00046677434991",
  "Philips Lightbulbs 40W Equivalent Soft White B11 Candelabra Base LED Light Bulb (3-Pack) 458711",
  "00046677178628",
  "00046677433208",
  "Philips Lightbulbs 60W Equivalent Soft White A19 Dimmable LED with Warm Glow Light Effect Household Light Bulb 455840",
  "Philips Lightbulbs 35W Equivalent Bright White (3000K) MR16 Dimmable LED Light Bulb 453498",
  "Philips Lightbulbs 60W Equivalent Daylight (5000K) A19 Dimmable LED Light Bulb 455873",
  "Philips Lightbulbs 65W Equivalent Daylight BR30 Dimmable LED Light Bulb 457085",
  "Philips Lightbulbs 50W Equivalent Bright White (3000K) MR16 Dimmable LED Flood Light Bulb 453480",
  "Philips Lightbulbs SlimStyle 60W Equivalent Soft White A19 Dimmable LED Light Bulb (3-Pack) 453530",
  "Philips Lightbulbs 50W Equivalent Bright White GU10 Dimmable LED Flood Light Bulb (E) 454363",
  "Philips Lightbulbs 65W Equivalent Daylight 5/6 in. Retrofit Trim Recessed Downlight Dimmable LED Flood Light Bulb (E)* 800061",
  "00046677433239",
  "50W Equivalent Bright White PAR20 Dimmable LED Flood Light Bulb (E)*",
  "Philips Lightbulbs 100W Equivalent Soft White Household A19 Dimmable LED with Warm Glow Light Effect Light Bulb 459107",
  "Philips Lightbulbs 75W Equivalent Soft White Household A19 Dimmable LED with Warm Glow Light Effect Light Bulb 459065",
  "Philips Lightbulbs 50W Equivalent Daylight 4 in. Retrofit Trim Recessed Downlight Dimmable LED Flood Light Bulb (E)* 800020",
  "Philips Lightbulbs 40W Equivalent Soft White Clear Multipurpose A15 Dimmable LED with Warm Glow Light Effect Light Bulb 458760",
  "Philips Lightbulbs 60W Equivalent Soft White Clear G25 Dimmable LED with Warm Glow Light Effect Light Bulb 459339",
  "Philips Lightbulbs 75W Equivalent Soft White (2700K) A21 Dimmable LED Light Bulb 451898",
  "Philips Lightbulbs 60W Equivalent Soft White Clear A19 Dimmable LED with Warm Glow Light Effect Light Bulb 458828",
  "Philips Lightbulbs 60W Equivalent Soft White F15 Post Light Dimmable LED Light Bulb 458620",
  "Philips Lightbulbs 40W Equivalent Soft White Clear G25 Dimmable LED with Warm Glow Light Effect Light Bulb 458794",
  "Philips Lightbulbs 40W Equivalent Soft White (2700K) B13 Dimmable Blunt Tip Candle LED Light Bulb 435065",
  "Philips Lightbulbs 40W Equivalent Soft White Clear A19 Dimmable LED with Warm Glow Light Effect Light Bulb 458737",
  "Philips Lightbulbs 65W Equivalent Soft White BR40 Dimmable with Warm Glow Light Effect LED Light Bulb (E) 457002",
  "Philips Lightbulbs 40W Equivalent Soft White (2200K - 2700K) A19 Dimmable LED with Warm Glow Light Effect Light Bulb (E) 455741",
  "Philips Lightbulbs 20W Equivalent Bright White (3000K) MR11 LED Flood Light Bulb 454157",
  "75W Equivalent Daylight (5000K) PAR30L Dimmable LED Flood Light Bulb",
  "Philips Lightbulbs 50W Equivalent Soft White R20 Dimmable with Warm Glow Light Effect LED Light Bulb (E) 456995",
  "Philips Lightbulbs 60W Equivalent Soft White B12 Dimmable Blunt Tip Candle with Warm Glow Light Effect LED Light Bulb 458687",
  "Philips Lightbulbs SlimStyle 65W Equivalent Daylight (5000K) BR30 Dimmable LED Flood Light Bulb 452482",
  "Philips Lightbulbs 40W Equivalent Soft White B12 Dimmable Blunt Tip Candle with Warm Glow Light Effect LED Light Bulb (E) 457119",
  "00046677458652",
  "00046677457181",
  "Philips Lightbulbs 25W Equivalent Soft White B12 Dimmable Blunt Tip Candle with Warm Glow Light Effect LED Light Bulb (E) 457226",
  "Philips Lightbulbs 65W Equivalent Soft White 5/6 in. Retrofit Trim Recessed Downlight Dimmable LED Flood Light Bulb (E)* 800038",
  "Philips Lightbulbs 60W Equivalent Soft White (2700K) F15 Post Light Dimmable LED Light Bulb 435081",
  "00046677454463",
  "00046677179380",
  "Philips Lightbulbs 25W Equivalent Soft White (2700K) B13 Dimmable LED Blunt Tip Candle Light Bulb 435040",
  "Philips Lightbulbs 40W Equivalent Soft White (2700K) A15 Fan Dimmable LED Light Bulb 435073",
  "Philips Lightbulbs 60W Equivalent Soft White Spiral Dusk-Till-Dawn CFL Light Bulb (E*) 405852",
  "Philips Lightbulbs 60W Equivalent Daylight (6500K) T2 Spiral CFL Light Bulb (E*) (4-Pack) 434399",
  "Philips Electric Shavers 100W Equivalent Daylight Deluxe T2 Twister CFL Light Bulb (4-Pack) (E*) 433557",
  "Philips Lightbulbs 100W Equivalent Soft White (2700K) T2 Spiral CFL Light Bulb (E*) 434738",
  "00762148265610",
  "EcoSmart Lightbulbs 65W Equivalent Soft White BR30 CFL Light Bulb (6-Pack) ESBR30146",
  "EcoSmart Lightbulbs 150W Equivalent Soft White (2700K) Spiral 3-Way CFL Light Bulb ESB9032",
  "EcoSmart Lightbulbs 60W Equivalent Bright White Spiral CFL Light Bulb (4-Pack) ESBM814435K",
  "EcoSmart Lightbulbs 90W Equivalent Day Light (5000K) PAR38 LED Flood Light Bulb ECS 38 90WE CW FL 120 FS1 BL",
  "EcoSmart Lightbulbs 65W Equivalent Soft White (2700K) Dimmable LED Indirect Recessed Downlight Bulb ECS RFK6 65WE W27 120 REC",
  "00887437021897",
  "EcoSmart Lightbulbs 60W Equivalent Soft White A19 Energy Star + Dimmable LED Light Bulb (4-Pack) A810SS-Q1D-01",
  "EcoSmart Lightbulbs 60W Equivalent Daylight A19 Energy Star + Dimmable LED Light Bulb (4-Pack) A810SS-Q1D-04",
  "EcoSmart Lightbulbs 50W Equivalent Bright White (3000K) PAR20 LED Flood Light Bulb ECS 20 50WE WW FL 120 TP",
  "EcoSmart Lightbulbs 120W Equivalent Bright White (3000K) PAR38 LED Flood Light Bulb (E)* ECS 38 120WE WW FL 120 TP",
  "EcoSmart Lightbulbs 75W Equivalent Bright White (3000K) PAR30 LED Flood Light Bulb (E)* ECS 30 75WE WW FL 120 TP",
  "EcoSmart Lightbulbs 90W Equivalent Day Light (5000K) PAR38 LED Flood Light Bulb ECS 38 90WE CW FL 120 FS1 BL",
  "75W Equivalent BR30 Daylight LED Light Bulb",
  "65W Equivalent BR30 Soft White LED Light Bulb (3-Pack)",
  "65W Equivalent Daylight BR30 LED Light Bulb (3-Pack)",
  "EcoSmart Lightbulbs 90W Equivalent Soft White (3000K) PAR38 LED Flood Light Bulb ECS 38 90WE WW FL 120 FS1 BL",
  "75W Equivalent BR40 Daylight LED Light Bulb",
  "EcoSmart Lightbulbs 40W Equivalent Soft White A19 Energy Star + Dimmable LED Light Bulb (4-Pack) A460ST-Q1D-0",
  "75W Equivalent BR30 Soft White LED Light Bulb",
  "EcoSmart Lightbulbs 35W Equivalent Soft White (3000K) MR16 GU10 LED Flood Light Bulb ECS 16 35WE WW FL GU10 120 FS1 BL",
  "65W Equivalent BR30 Bright White LED Light Bulb",
  "50W Equivalent R20 Daylight LED Light Bulb",
  "00887437027981",
  "GE Lightbulbs 60W Equivalent Soft White General Purpose LED Bright Stik light bulb (3-Pack) LED10S3/96",
  "GE Reveal Lightbulbs 60W Equivalent Reveal (2700K) A19 Dimmable LED Light Bulb LED10DA19RVLESTP",
  "00043168835725",
  "GE Reveal Lightbulbs 65W Equivalent Reveal (2700K) BR30 Dimmable LED Flood Light Bulb LED12DR303RVLES",
  "GE Lightbulbs 60W Equivalent Soft White (2700K) General Purpose LED Light Bulb (8-Pack) LED10LS8/32",
  "00043168219075",
  "00046677459031",
  "00046677458089",
  "Philips Lightbulbs SlimStyle 65W Equivalent Soft White A19 Dimmable LED with CRI 90 Light Bulb 455493",
  "Philips Lightbulbs SlimStyle 65W Equivalent Soft White (2700K) BR30 Dimmable LED with CRI 90 Light Bulb 455485",
  "Feit Electric Lightbulbs 65W Equivalent Soft White (2700K) BR30 Dimmable Enhance LED Light Bulb BR30/927/LED/36",
  "Feit Electric Lightbulbs 65W Equivalent Soft White BR30 Dimmable Enhance LED Light Bulb (6-Pack) BR30DM65/LED/MP/6/24",
  "Commercial Electric Ceiling Mounted Lighting Brushed Nickel LED Energy Star Flushmount HUI8011L-2/BN",
  "00046335979390",
  "Commercial Electric Recessed Lighting 6 in. White LED Recessed Gimbal Trim CER6742AWH30",
  "Commercial Electric Ceiling Mounted Lighting Brushed Nickel LED Mushroom Flushmount IPF3011L/BN",
  "00080083580071",
          ]

=begin


FileUtils.mkdir ("/Users/David/dropbox/JDP_Trading/#{t}")

stores.each do |store|
  output = []
  browser = Watir::Browser.new
  browser.goto "https://www.google.com/search?lsf=seller:8740,store:2221886705553283364&tbm=shop&q=Philips+Lightbulbs+SlimStyle+40W+Equivalent+Soft+White&sa=X&ved=0ahUKEwi5r8H664LKAhVQxWMKHZE5CeAQljAIEQ&biw=772&bih=724"
  change_store = browser.link :text => 'Change store'
  if change_store.exists?
    change_store.click
  else
    sleep 45
    browser.close
    puts "error with clicking change store link"
    next
  end
  store_text = browser.text_field :class => '_pWb jfk-textinput'
  if store_text.exists?
    store_text.set "#{store}"
  else
    browser.close
    puts "error with changing #{store}"
    next
  end
  find_stores = browser.input(:class => 'jfk-button jfk-button-standard')
  if find_stores.exists?
    find_stores.click
  else
    browser.close
    puts "error with clicking #{store}"
    next
  end
  sleep 3
  click_stores = browser.link(:class => '_Muc jfk-button jfk-button-standard')
  if click_stores.exists?
    click_stores.click
  else
    browser.close
    puts "error with clicking #{store}"
    next
  end
  q = "#{browser.html}"
  unless q.downcase.include?("#{store.downcase}")
    puts "#{store} name does not match search on Google"
  end
  z = "#{browser.url}"
  y = "#{z.to_s.gsub("https://www.google.com/search?lsf=seller:8740,store:2221886705553283364&tbm=shop&q=Philips+Lightbulbs+SlimStyle+40W+Equivalent+Soft+White&sa=X&ved=0ahUKEwi5r8H664LKAhVQxWMKHZE5CeAQljAIEQ&biw=772&bih=724#lsf=seller:8740,store:","'").gsub('&tbm=shop&q=Philips+Lightbulbs+SlimStyle+40W+Equivalent+Soft+White',"',")}"
  File.open("/Users/David/dropbox/JDP_Trading/#{t}/#{store}.csv", "wb") { |file| file.write("#{y}") }
  browser.close
end
=end



FileUtils.mkdir ("/Users/David/dropbox/JDP_Trading/#{t}")

i = 0

products.each do |product|
  output = []
  browser = Watir::Browser.new
  browser.goto "https://www.google.com/search?lsf=seller:8740,store:2221886705553283364&tbm=shop&q=Philips+Lightbulbs+SlimStyle+40W+Equivalent+Soft+White&sa=X&ved=0ahUKEwi5r8H664LKAhVQxWMKHZE5CeAQljAIEQ&biw=772&bih=724"
  product_text = browser.text_field :class => '_fGf'
  if product_text.exists?
    product_text.set "#{product}"
  else
    sleep 45
    browser.refresh
    product_text.set "#{product}"
  end
  product_btn = browser.button :id => '_dGf'
  if product_btn.exists?
    product_btn.click
  else
    sleep 5
    product_btn.click
  end
  item_html = "#{browser.html}"
  nokogiri_object = Nokogiri::HTML(item_html)
  p_id = nokogiri_object.xpath("//h3[@class='r']/descendant::a[@class='pstl']").first
  w = "#{p_id.to_s}"
  unless w.downcase.include?("#{product.downcase}")
    puts "#{product} name does not match search on Google"
  end
  w_2 = w.gsub("<a href=\"/shopping/product/","'").gsub(/[?].*/,"',")
  File.open("/Users/David/dropbox/JDP_Trading/#{t}/#{i}.csv", "wb") { |file| file.write("#{w_2}") }
  browser.close
  i += 1
end

