class ImyanmarhouseController < ApplicationController
  def scrape_data_imyanmar
    require 'openssl'
    doc = Nokogiri::HTML(open('https://www.imyanmarhouse.com/', :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))

    # entries = doc.css('.lagos-market-rates-inner')
    # rate = entries.css('table')[0].css('tr')[1].css('td')[1].text
    # @formattedrate = rate[6..8]
    render template: 'imyanmarhouse/home'
  end
end
