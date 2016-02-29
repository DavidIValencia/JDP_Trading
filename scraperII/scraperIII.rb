require 'nokogiri'
require 'watir-webdriver'
require 'csv'
require 'fileutils'
t = '2016-02-08 13:00:10 -0800'

product = [
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
  "Philips Lightbulbs 65w equivalent soft white br30 dimmable LED flood light bulb (E) 459826"
          ]

product_id = [
'10380463945350556587','6217884950688183155','17274607632228695707','2682084245784049823','15292772130714563967','17106461756080616484','3354541382703504085','13540192918621207090','16220450426180062734','4023543691699147507','7379772672893145390','16253093263830628387','10509146226212926973','12349870726790987391','12767381654774580674','17688346775542433469','15963340409973003759','2537156093288205837','9061957719602087461','7776354260933382255','15292772130714563967','8740139844070831204','3571442737734953556','6877413519984989523','6920877932878457773','4756797560298311018','3891926687395267773','8841919107237078634','13025351601115903784','13620910063459088876','12665332394548063189','11338885333803666741','16248316036663195996','6495041527986330751','1651019640930877312','12349870726790987391','11650400460826406385','7419825619990288148','1043047672447314204','84417907051693390','3144358113282643229','3752349569472793698','11964351964029265799','10612696984030924276','8729518032622752248','15859610972624251944','1651019640930877312','3882336588654134593','11587640418488564520','11536894971771819090','565941487697852456','1529591419662417868','6217884950688183155','14570269610358368532','17394285368042790795','12533606957334448925','5463616184864243908','17274607632228695707','6706108831917590555','12049392713063525512','10612696984030924276','107821584684751271','3917243717207400044','4150017064298140742','18075304873297740863','6043238751274152461','3454694415676680779','5143732734450818799','1750626985465141903','13522171722615101077','17936354061863047052','1251802379493908149','6890737770682133857','9395425376518453266','14424807123717710512','15470283859960418903','15623955308153527482','4294094064228644476','12619802577650764662','1750626985465141903','15551948826399895839','12251409012803894981','7125358595447540733','3651172011832034557','10478182966705171618','745668634217243379','14703945355408705121','14904545373032462155','10058384415048582283','7352404050126086754','4545987419901991601','9637743800657754968','11428757163884904320','16312447700019917890','5837646448234653961','14033217699217073693','823761270995761079','8607703363848217496','15830099938276058251','9755651016327317174','16500594127314767206','12460086993250371648','17497666777785720714','13257426479034669861','17522802068608205974','12634468365968802345','1847046790868939264','18427903043835500977','4013378108194290164','1419477090791701758','14693735956736034103','13493040561631924310','2565730335134288604','13625566069200894281','6452401939884936820','9523538317567160513','13458724762608537493','15456784138233788291','7257499505208441390','9198288870992859427','13856374714654963388','15713817492726953847', '452306307756260746'
             ]

store = [
"4750 S Decatur Blvd, Las Vegas",
"4900 East 2nd Street, Casper",
"4900 Se 14th St, Des Moines",
"500 Elsinger Blvd, Conway",
"507 West 19th Street, El Dorado",
"51 N Mccain Drive, Frederick",
"5125 Summit Ridge Ct, Reno",
"520 Us Highway 101 North, Crescent City",
"555 Hubbard Ave-Unit 21, Pittsfield",
"615 Arsenal Street, Watertown, MA, 02472",
"6325 I-55 North, Jackson",
"6400 Alondra Blvd Paramount, CA",
"65 Independence Dr, Hyannis",
"650 Ponce De Leon, Atlanta",
"650 Stillwater Ave, Bangor",
"6900 Pines Road, Shreveport",
"7345 Delridge Way SW Seattle, WA 98106",
"7545 N Mesa Street, El Paso 79912",
"759 Harvest Ln, Williston",
"80 Buckland Hills Dr; Manchester, CT",
"8000 Folsom Blvd, Sacramento",
"855 Lane Ave South, Jacksonville",
"86004 AZ",
"9320 Corporation Dr, Indianapolis, IN 46256",
"937 N Westridge Drive, Saint George, UT, 84770",
"9971 Mountain View Dr, West Mifflin",
"Bennington VT",
"Catonsville MD",
"Chicopee MA",
"Cicero IL",
"Conway AR",
"Dickson City PA",
"East El Paso TX",
"Ellicott City MD",
"Ellsworth ME",
"Evanston IL",
"Glastonbury, CT",
"Iron Mountain MI",
"Las Cruces NM",
"Park City UT",
"Rhode Island Ave Washington DC",
"Roosevelt Blvd Philadelphia, PA 19124",
"Ross Township PA",
"Sioux Falls",
"W Little Rock AR",
"W8141 Highway Us 2, Iron Mountain",
"West Mifflin PA",
  ]

store_id = [
'13854981053176527802',
'16512624041976138469',
'734008034973891497',
'1202791634744293435',
'3894943072004006400',
'6277687694578225762',
'5887875389295057973',
'1131648648877755566',
'6670259326929981690',
'3963407762955875167',
'16574594431389826985',
'5963332734948596167',
'17128492583363851392',
'6699425599564428810',
'15595320443848770725',
'17702271369802394764',
'11838677800107424729',
'15599679131237699233',
'11193247023101156029',
'14204016322763060661',
'6867713199049615866',
'17636043318762536018',
'2058533600694667206',
'5730152520110255098',
'9729894161361590646',
'1988715515618182343',
'10531018817528625039',
'18346287396175848474',
'1028777451582443611',
'1713884584425126667',
'1202791634744293435',
'4623405036882375845',
'7089091077124391211',
'9675220025785394518',
'12420391044519531869',
'18201871430242714594',
'17097489851512058608',
'17512887657898926342',
'15608876930016804792',
'14118828105712472902',
'1775954380663256527',
'16821477070451923509',
'3589702622138462979',
'16301213160329307081',
'6302485185865260364',
'17512887657898926342',
'1988715515618182343',
  ]


browser = Watir::Browser.new :firefox, :profile => 'default'
store_counter = 0
while store_counter < store.length do
  product_counter = 0
  while product_counter < product.length do
    output = Hash.new
    browser.goto "https://www.google.com/shopping/product/#{product_id[product_counter]}?lsf=seller:8740,store:#{store_id[store_counter]}&biw=1080&bih=518&noj=1&q="
    if browser.text.include? "To continue, please type the characters below:"
      browser.close
      sleep 240
      browser = Watir::Browser.new :firefox, :profile => 'default'
      browser.goto "https://www.google.com/shopping/product/#{product_id[product_counter]}?lsf=seller:8740,store:#{store_id[store_counter]}&biw=1080&bih=518&noj=1&q="
      if browser.text.include? "To continue, please type the characters below:"
        browser.close
        sleep 240
        browser = Watir::Browser.new :firefox, :profile => 'default'
        browser.goto "https://www.google.com/shopping/product/#{product_id[product_counter]}?lsf=seller:8740,store:#{store_id[store_counter]}&biw=1080&bih=518&noj=1&q="
        item_html = "#{browser.html}"
      else; item_html = "#{browser.html}"
      end
    else; item_html = "#{browser.html}"
    end
    unless item_html.downcase.include?("#{product[product_counter][0...8].downcase}")
      File.open("/Users/David/dropbox/JDP_Trading/#{t}/log/#{store_counter}000#{product_counter}.txt", "wb") { |file| file.write("#{product[product_counter]} is not present on page")}
    end
    unless item_html.downcase.include?("#{store[store_counter][0...8].downcase}")
      File.open("/Users/David/dropbox/JDP_Trading/#{t}/log/#{store_counter}111#{product_counter}.txt", "wb") { |file| file.write("#{store[store_counter]} is not present on page")}
    end
    nokogiri_object = Nokogiri::HTML(item_html)
    bulb = nokogiri_object.xpath("//h1[@class='_Gih']").first.to_s.gsub('</h1>',"").gsub(/(\A.*[>])/,"~")
    stock = nokogiri_object.xpath("//h2[@class='_Zih']/span[@class='_Ujh']/span").to_s.gsub('</span>',"").gsub(/(\A.*[>])/,"~")
    price = nokogiri_object.xpath("//h2[@class='_Zih']/span[@class='_Xjh']/span").to_s.gsub("</span>","").gsub('<span>',"")
    output.merge!("#{store[store_counter]}" + stock + bulb => price)
    CSV.open("/Users/David/dropbox/JDP_Trading/#{t}/#{product_counter}~#{store[store_counter]}.csv", "wb") {|csv| output.to_a.each {|elem| csv << elem} }
    product_counter += 1
  end
  store_counter += 1
end
browser.close


#create a new folder within dropbox :)
#Open browser with js deactivated :)
#Navigate and iterate through each product in the store and create a .csv for each one using if statements :)
#do this until product list is gone through :)
#Have an if statement so it can bail itself out of CAPTCHA once
#close the browser and start the next iteration

