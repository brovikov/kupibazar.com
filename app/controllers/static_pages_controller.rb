# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController

  def faq
    @item = Item.where(  "img <> 'https://db.tt/kLZjK6hA' AND status > '1' AND status <> '9'  " ).last( 16 )

  end
  
  def help
  end

  def about
  end
end
