# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController

  def faq
    @item = Item.where(  "img <> 'https://db.tt/kLZjK6hA' AND status > '1'  " ).last( 16 )

  end
  
  def help
  end

  def about
       @item = Item.where(  "img <> 'https://db.tt/kLZjK6hA' AND status > '1'  " ).last( 16 )
  end
end
