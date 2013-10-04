# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  status     :integer          default(0), not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ActiveRecord::Base
  attr_accessible :status, :id, :user_id, :items_attributes
  has_many :items, :dependent => :destroy
  belongs_to :user
  accepts_nested_attributes_for :items,  :allow_destroy => true
  before_validation :parse_img
  before_validation :parse_rate
 
  private
  def parse_img
    self.items.each do |img|   
      if img.link[0,9] == "http://ru" 
         img.link[7..9] = ""
      end
      #  URL example http://ru.aliexpress.com/wholesale?SearchText=654654654&catId=0
      doc = Nokogiri::HTML(open(img.link))
      img.img = doc.css('meta')[7]['content'] if img.img.blank?
   end   
  end 
    def parse_rate
      self.items.each do |rate|   
          if rate.link[0,9] == "http://ru" 
             rate.link[7..9] = ""
          end
        doc = Nokogiri::HTML(open(rate.link))
        rate.seller_rate = "Best Rate" #("a[class='seller-level-lnk']")['src'] #if img.img.blank?
        
                  
     end   
   end
end
