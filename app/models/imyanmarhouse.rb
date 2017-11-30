class Imyanmarhouse < ActiveRecord::Base
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'open_uri_redirections'

  def self.imyanmarhouse_data_for_sale
    # begin
    #   ActiveRecord::Base.transaction do
        (78..1602).each do |i|
          puts ''
          puts '################################### Page-'+i.to_s+'########################################'
          puts ''

          if i == 1
            base_url = "https://www.imyanmarhouse.com/en/search/for-sale/all-region/all-township"
          else
            base_url = "https://www.imyanmarhouse.com/en/search/for-sale/all-region/all-township/page"+i.to_s
          end
          doc = Nokogiri::HTML(open(base_url, :allow_redirections => :safe))
          link = doc.css('.sm-text-center a[href^="/en/sale/"]')
          link.each do |l|
            url = l.attr("href").to_s
            url = "https://www.imyanmarhouse.com"+url
            document = Nokogiri::HTML(open(url, :allow_redirections => :safe))
            Imyanmarhouse.insert_into_imyanmarhouse_data(document) unless document == nil
          end
        end

    #   end
    # rescue Exception => exception
    #   logger.error(exception.to_s) #handle exception
    # end
  end

  def self.imyanmarhouse_data_for_rent
    (1..3169).each do |i|
      puts ''
      puts '################################### Page-'+i.to_s+'########################################'
      puts ''
      if i == 1
        base_url = "https://www.imyanmarhouse.com/en/search/for-rent/all-region/all-township"
      else
        base_url = "https://www.imyanmarhouse.com/en/search/for-rent/all-region/all-township/page"+i.to_s
      end

    end
  end

  def self.insert_into_imyanmarhouse_data(doc)
    imh = Imyanmarhouse.new
    header_row = doc.css(".hidden-xs~ .b-grey+ .row")
    body_row = doc.css(".no-border .panel-body .row")

    if header_row != nil && body_row != nil
      imh.transaction_type = "Sale"
      imh.property_type = header_row.css(".active, .link-color")[3].text unless header_row.css(".active, .link-color")[3] == nil
      imh.region = header_row.css(".active, .link-color")[1].text unless header_row.css(".active, .link-color")[1] == nil
      imh.township = header_row.css(".active, .link-color")[2].text unless header_row.css(".active, .link-color")[2] == nil
      imh.price = body_row[1].css(".fs-18").text.gsub(/[\r\n\t ]/,'') unless body_row[1].css(".fs-18") == nil
      imh.bed_room = body_row[1].css(".sm-p-b-15 span")[2].text.gsub(/[\t\n\rRooms  ]/,'') unless body_row[1].css(".sm-p-b-15 span")[2] == nil
      imh.bath_room = body_row[1].css(".sm-p-b-15 span")[0].text.gsub(/[\t\n\rRooms  ]/,'') unless body_row[1].css(".sm-p-b-15 span")[0] == nil
      imh.phone = doc.css(".col-lg-offset-2 .modal-body p")[0].text unless doc.css(".col-lg-offset-2 .modal-body p")[0] == nil
      imh.description = body_row[2].css(".word-break").text.gsub(/[\r\n\t ]/,'') unless body_row[2].css(".word-break") == nil
      imh.property_created_time = body_row[0].css(".col-xs-12 div")[0].text unless body_row[0].css(".col-xs-12 div")[0] == nil
      imh.property_id = body_row[0].css(".text-right strong").text.gsub(/[S-]/,'') unless body_row[0].css(".text-right strong") == nil

      if  body_row[2].css('li').count == 2
        imh.finish_state = body_row[2].css('li')[0].text unless body_row[2].css('li')[0] == nil
        imh.furnished_or_not = body_row[2].css('li')[1].text unless body_row[2].css('li')[1] == nil
      else
        imh.furnished_or_not = body_row[2].css('li')[0].text unless body_row[2].css('li')[0] == nil
      end

      imh.save!
    end
  end


end
