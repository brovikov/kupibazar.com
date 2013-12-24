# -*- encoding : utf-8 -*-
 class ItemsController < ApplicationController
     load_and_authorize_resource #cancan
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
     bf = @item.value
     if @item.havy
       prcnt = true
     else
       prcnt = false
     end 
     @item.update_attributes(params[:item]) 
     if @item.status == 2
       current_user.update_attributes( balance: (current_user.balance + (bf - @item.value)*35.3*0.1 + (bf - @item.value)*35.3).round( 2 ) )
       if prcnt != @item.havy
         if @item.havy
           current_user.update_attributes( balance: (current_user.balance - @item.value*35.3*0.1 ) )
         else
           current_user.update_attributes( balance: (current_user.balance + @item.value*35.3*0.1 ) )
         end
       end
     end 
     respond_with @item
     @item.order.save 
   end
 end 
