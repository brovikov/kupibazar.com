# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  status      :integer          default(0), not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  order_value :decimal(6, 2)    default(0.0)
#

class Order < ActiveRecord::Base
  include ApplicationHelper
  attr_accessible :status, :id, :user_id, :items_attributes, :order_value
  has_many :items, :dependent => :destroy
  belongs_to :user
  accepts_nested_attributes_for :items,  :allow_destroy => true
  before_validation :parse_img
  before_validation :parse_rate
#  before_save :total_value

  private
  def parse_img
    self.items.each do |img|   
      if img.link[0,9] == "http://ru" 
         img.link[7..9] = ""
      end
      #  URL example http://ru.aliexpress.com/wholesale?SearchText=654654654&catId=0
      begin
        doc = Nokogiri::HTML(open(img.link))
        img.img = doc.css('meta')[8]['content'] if img.img.blank? 
      rescue
        img.img = "https://db.tt/kLZjK6hA"
      end
      if img.img[img.img.length-3,img.img.length-1] != "jpg"
        img.img = "https://db.tt/kLZjK6hA"  
      end
      # doc = Nokogiri::HTML(open(img.link)) 
      # img.img = doc.css('meta')[7]['content'] if img.img.blank?
      
   end   
  end 
    def parse_rate
      self.items.each do |rate|   
          if rate.link[0,9] == "http://ru" 
             rate.link[7..9] = ""
          end
        #doc = Nokogiri::HTML(open(rate.link))
        rate.seller_rate = "Best Rate" #("a[class='seller-level-lnk']")['src'] #if img.img.blank?
     end   
   end
  def total_value  
    self.order_value = (self.items.to_a.sum{|ttl| price( ttl, self.user )[:val]}).round( 2 )
  end 
  
end
