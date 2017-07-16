#!/usr/bin/ruby -w

require 'rubygems'
require 'nokogiri'
require 'open-uri'

COIN_MARKET_URL = "https://coinmarketcap.com/all/views/all/"

def get_the_market_value_of_a_cryptocurrency(url)
  page = Nokogiri::HTML(open(url))
  market_value = page.xpath('//td[4]/a')
  market_value.text
end

def get_the_market_value_of_all_cryptocurrency(url)
  currency_market_value = Hash.new()
  page = Nokogiri::HTML(open(url))
  page.xpath('//td[2]/a').each do |currency|
    currency_name = currency.text.downcase
    currency_name = currency_name.split('').join('-')
    url ="https://coinmarketcap.com/all/views/all/#{currency_name}.html"
  end
  currency_market_value.each do |key, value|
    puts "#{key}: #{value}"
  end
end

puts get_the_market_value_of_all_cryptocurrency(COIN_MARKET_URL)
