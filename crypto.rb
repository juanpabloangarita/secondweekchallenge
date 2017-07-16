require 'rubygems'
require 'nokogiri'   
require 'open-uri'

def get_all_the_prices(url)
    currencies = []
    prices = []
    page = Nokogiri::HTML(open(url))
    scrap_name = page.xpath('//td[@class = "no-wrap currency-name"]/a')
    scrap_name.each do |link| 
        currencies.push(link.text.split)
    end
    scrap_coin = page.xpath('//td[@class = "no-wrap text-right"]/a[@class = "price"]')
    scrap_coin.each do |link| 
        #h = link.text.split  #why doesn't this save in the h array the results? why is it that we have to use push or store?
        prices.push(link.text.split)
    end
    result = Hash.new
    currencies.zip(prices) { |x,y| result[x] = y }    

    #puts result
    result.each do |name, price| 
        puts "NAME:\t#{name}\t PRICE:\t#{price}"
        puts ""
    end

end

get_all_the_prices("https://coinmarketcap.com/all/views/all/")



#html.no-js body div.container div.row div.col-xs-12.col-sm-12.col-md-12.col-lg-10 div.row div.col-xs-12 div#currencies-all_wrapper.dataTables_wrapper.no-footer table#currencies-all.table.dataTable.no-footer tbody tr#id-bitcoin.odd td.no-wrap.text-right a.price
#esto que sucede con el tree de gpath, es que hay espacios, por ejemplo en td class ="no-wrap text-right"


#html.no-js body div.container div.row div.col-xs-12.col-sm-12.col-md-12.col-lg-10 div.row div.col-xs-12 div#currencies-all_wrapper.dataTables_wrapper.no-footer table#currencies-all.table.dataTable.no-footer tbody tr#id-bitcoin.odd td.no-wrap.currency-name a
#este es el nombre