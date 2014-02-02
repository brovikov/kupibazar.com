# -*- encoding : utf-8 -*-
 class ItemsController < ApplicationController
     load_and_authorize_resource #cancan
     include ApplicationHelper
 respond_to :html, :json 
   
   def index
     
     @item= Item.search(params[:search])

    respond_to do |format|
      format.html
      format.js
    end
  end

  
   def update
     @item = Item.find(params[:id])
     bf = price( @item, @item.order.user )[:val]
     @item.update_attributes(params[:item]) 
     if @item.status == 2
       b_new = price( @item, @item.order.user )[:val]
       delta = bf - b_new
       @item.order.user.update_attributes( balance: (@item.order.user.balance + delta ) )
       @item.update_attributes( value_total: b_new )
    end 
     respond_with @item
     @item.order.save

   end
 end 
