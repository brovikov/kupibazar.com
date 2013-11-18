# -*- encoding : utf-8 -*-
class AdminItemsController < ApplicationController
    authorize_resource :class => false
    include ApplicationHelper
  
  def index
    @items = Item.paginate page: params[:page_full], order: 'created_at desc',
    per_page: 2
    @items_acc= Item.where( status: 1 ).paginate page: params[:page_acc], order: 'created_at desc',
    per_page: 2
    @items_nacc= Item.where( status: 0 ).paginate page: params[:page_nacc], order: 'created_at desc',
    per_page: 2

    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
      flash[:notice] = "Заказ успешно удален."
      redirect_to admin_items_url
  end
  
   def status
     @item = Item.find(params[:id])
    respond_to do |format|
        @item.status = 1 
        @item.save
        Order.find(@item.order.id).items.each do |ord_it| # Циклическая проверка статуса Items
          if ord_it.status == 1                           # Если все Items = 1 то и order.status = 1
            @item.order.status = 1
          else 
            @item.order.status = 0                         # Если нет, то  order.status = 0
            break
          end 
          @item.order.save
        end
      format.html { redirect_to list_confirm_admin_items_url, notice: 'Статус заказа успешно обновлен.' }
        format.json { head :no_content }
      end      
  end
  def pay_for_override # Принудительная оплата заказа
    @item = Item.find(params[:id])
    if @item.status<2 
    @item.order.update_attributes( status: 2 ) 
    order = Order.find( @item.order.id )
          order.items.each do |item|  
          item.update_attributes( status: 2 )
        end
        current_user.update_attributes( balance: current_user.balance - @item.order.order_value )
        redirect_to orders_url, notice: 'Статус заказа успешно обновлен.'
    else 
      redirect_to admin_items_url, notice: 'Как-то странно оплачивать дважды...'
    end 
  end
  
  def list_pay
    @items_for_pay =  Item.where( status: 2 ).paginate page: params[:page_items], order: 'created_at desc',
    per_page: 1
    respond_to do |format|
      format.html
      format.js
    end
  end   
  
  def list_confirm
    @items_for_confirm =  Item.where( status: 0 ).paginate page: params[:page], order: 'created_at desc',
    per_page: 1
    respond_to do |format|
      format.html
      format.js
    end
  end   
  
  def edit
    @item = Item.find(params[:id])
    respond_to do |format|
    format.html 
    format.js
    end
  end
  
   def update
     @item = Item.find(params[:id])

     @item.update_attributes(params[:item]) 
     respond_with @item
     redirect_to list_pay_admin_items_url, notice: 'Как-то странно оплачивать дважды...'  
   end
    
  
  def payd
    respond_to do |format|
      @item = Item.find(params[:id])
      @item.update_attributes( status: 7 )
      @item.order.update_attributes( status: 7 )
      format.html { redirect_to list_pay_admin_items_url, notice: 'Заказ успешно выкуплен.' }
      format.json { head :no_content }       
    end 
  end
  
  def cancel                       # Отклонение оплаченного заказа
    @item = Item.find(params[:id])
    respond_to do |format|
        if @item.status == 2
          if @item.havy
            prcnt = 20
          else 
            prcnt = 10
          end 
           current_user.update_attributes( balance: (current_user.balance + (@item.value*prcnt/100 + @item.value)*35.3).round( 2 ) )
           @item.update_attributes( status: 9, value: 0 )
           @item.order.save  
           format.html { redirect_to list_pay_admin_items_url, notice: 'Статус заказа успешно обновлен.' }
           format.json { head :no_content }       
        else
           @item.update_attributes( status: 9, value: 0 )
           @item.order.save  
           format.html { redirect_to list_confirm_admin_items_url, notice: 'Статус заказа успешно обновлен.' }
           format.json { head :no_content }       
        end
    end
  end

def re_check                       # Отправка заказа на повторную проверку
    @item = Item.find(params[:id])
    respond_to do |format|
        if @item.status == 2
          if @item.havy
            prcnt = 20
          else 
            prcnt = 10
          end 
           current_user.update_attributes( balance: (current_user.balance + (@item.value*prcnt/100 + @item.value)*35.3).round( 2 ) )
           @item.update_attributes( status: 0 )
           @item.order.save  
           format.html { redirect_to list_pay_admin_items_url, notice: 'Статус заказа успешно обновлен.' }
           format.json { head :no_content }       
        else
           @item.update_attributes( status: 1 )
           @item.order.save  
           format.html { redirect_to list_confirm_admin_items_url, notice: 'Статус заказа успешно обновлен.' }
           format.json { head :no_content }       
        end
    end
  end

  def list_payments
    @list_payments =  Payment.where( status: [0, 2] ).paginate page: params[:page_payments], order: 'created_at desc',
    per_page: 2
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def list_lotts
    @list_lotts =  Lott.where( status: 0 ).paginate page: params[:page_lotts], order: 'created_at desc',
    order: 'lot_number desc', per_page: 20
    respond_to do |format|
      format.html
      format.js
    end
  end
  def list_lotts_all
    @list_lotts =  Lott.paginate page: params[:page_lotts], order: 'created_at desc',
    per_page: 20
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def list_items
    @items =  Item.where( status: 7 ).paginate page: params[:page_items], order: 'created_at desc',
    per_page: 20
    respond_to do |format|
      format.html
      format.js
    end
  end   
  
end 
  
