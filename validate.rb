#! /usr/bin/env ruby

require 'rubygems'
require 'nokogiri'   
require 'open-uri'

PAGE_URL01 = "http://annuaire-des-mairies.com/val-d-oise.html"
#PAGE_URL02 = "http://annuaire-des-mairies.com/95/vaureal.html"
page_url02 = "http://annuaire-des-mairies.com"
requete = /\w+\.?\+?\w+?@\w+-?\w+\.\w+/



end_of_web=[] #the ending of the website, ie: ./95/vaureal.html

url01 = Nokogiri::HTML(open(PAGE_URL01))
url01.xpath('//tr//td/p/a').each do |node|  # con ////tbody no funciona, con el siguiente si, que extraño
	end_of_web.push(node['href'])
end

joined_web=[]
end_of_web.each {|end_element| joined_web.push([page_url02,end_element].join)}

#puts joined_web


result = Hash.new
joined_web.each do |website|
	unfiltered=[]
	url02 = Nokogiri::HTML(open(website))
	url02.xpath('//tr//td[@class = "style27"]/p[@class = "Style22"]/font').each do |node|  #con ////tbody no funciona, con el siguiente si, que extraño
  		unfiltered.push(node.text.match requete)
	end

	for i in 0..unfiltered.length
	result[website] = unfiltered[i] unless unfiltered[i].nil?
	end
end

result.each {|x,y| puts "WEBSITE #{x}:\t EMAIL: #{y}}"}


=begin
joined_web.each do |website|
	url02 = Nokogiri::HTML(open(website))
	url02.xpath('//tr//td[@class = "style27"]/p[@class = "Style22"]/font').each do |node|  #con ////tbody no funciona, con el siguiente si, que extraño
  		puts node.text.match requete
	end
end
=end


=begin
whole_url = Hash.new
filt_email=[] #filtering the email that was regexed

page_02 = Nokogiri::HTML(open(PAGE_URL02))
page_02.xpath('//tr//td[@class = "style27"]/p[@class = "Style22"]/font').each do |node|  #con ////tbody no funciona, con el siguiente si, que extraño
  filt_email.push(node.text.match requete) #por que el push funciona y no el y = node.test.match requete ????
end

for i in 0..filt_email.length
whole_url[PAGE_URL02] = filt_email[i] unless filt_email[i].nil?  #imprima filt_email[i] a menos que el valor de filt_email[i] sea nulo. Si la derecha se cumple, no imprima nada.
end

puts whole_url

=end

#////html////body/////table/////tbody//tr//td/////table/////tbody//tr//td/////table/////tbody//tr//td/////table/////tbody

=begin

#CSS
page = Nokogiri::HTML(open(PAGE_URL02))
puts page.css('tbody:nth-child(1) > tr:nth-child(4) > td:nth-child(2)').text

 #body > table:nth-child(1) > tbody:nth-child(1) > tr:nth-child(3) > td:nth-child(1) > table:nth-child(1) > tbody:nth-child(1) > tr:nth-child(1) > td:nth-child(1) > table:nth-child(8) > tbody:nth-child(1) > tr:nth-child(2) > td:nth-child(1) > table:nth-child(1) >
 # 

#html > body > table > tbody > tr > td > table > tbody > tr > td > table > tbody > tr > td > table >


=end

