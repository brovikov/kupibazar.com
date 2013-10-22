 class ItemsController < ApplicationController
 respond_to :html, :json 

  
   def update
     @item = Item.find(params[:id])
     bf = @item.value
     @item.update_attributes(params[:item]) 
     if @item.status == 2
       current_user.update_attributes( balance: (current_user.balance + (bf - @item.value)*35.3*0.1 + (bf - @item.value)*35.3).round( 2 ) )
     end 
     respond_with @item
     @item.order.save 
   end
 end 