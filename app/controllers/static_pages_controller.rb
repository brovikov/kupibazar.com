# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController

  def faq
    @item = Item.last( 8 )
    if @item == nil 
      @item = Item.all
    end
  end
  
  def help
  end

  def about
  end
end
