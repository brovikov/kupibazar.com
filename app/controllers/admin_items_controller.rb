# -*- encoding : utf-8 -*-
class AdminItemsController < ApplicationController
    authorize_resource :class => false
    include ApplicationHelper
  
  def index
    @items = Item.paginate page: params[:page_full], order: 'created_at desc',
    per_page: 30
    @items_acc= Item.where( status: 1 ).paginate page: params[:page_acc], order: 'created_at desc',
    per_page: 30
    @items_nacc= Item.where( status: 0 ).paginate page: params[:page_nacc], order: 'created_at desc',
    per_page: 30

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
        @item.order.user.update_attributes( balance: @item.order.user.balance - @item.order.order_value )
        redirect_to admin_items_url, notice: 'Статус заказа успешно обновлен.'
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
          if @item.value > 10 
              #current_user.update_attributes( balance: (current_user.balance + (@item.value*prcnt/100 + @item.value)*35.3).round( 2 ) )
              @item.order.user.update_attributes( balance: (@item.order.user.balance + (@item.value*prcnt/100 + @item.value)*35.3).round( 2 ) )           
              @item.update_attributes( status: 9, value: 0 )
              @item.order.save  
              format.html { redirect_to list_pay_admin_items_url, notice: 'Статус заказа успешно обновлен.' }
              format.json { head :no_content }       
          else 
              @item.order.user.update_attributes( balance: (@item.order.user.balance + (@item.value + 1)*35.3).round( 2 ) )
              @item.update_attributes( status: 9, value: 0 )
              @item.order.save  
              format.html { redirect_to list_pay_admin_items_url, notice: 'Статус заказа успешно обновлен.' }
              format.json { head :no_content }       
          end
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
          if @item.value > 10 
              @item.order.user.update_attributes( balance: (@item.order.user.balance + (@item.value*prcnt/100 + @item.value)*35.3).round( 2 ) )
              @item.update_attributes( status: 0 )
              @item.order.save  
              format.html { redirect_to list_pay_admin_items_url, notice: 'Статус заказа успешно обновлен.' }
              format.json { head :no_content }       
          else 
              @item.order.user.update_attributes( balance: (@item.order.user.balance + (@item.value + 1)*35.3).round( 2 ) )
              @item.update_attributes( status: 0 )
              @item.order.save  
              format.html { redirect_to list_pay_admin_items_url, notice: 'Статус заказа успешно обновлен.' }
              format.json { head :no_content }       
          end
    
        else
           @item.update_attributes( status: 1 )
           @item.order.save  
           format.html { redirect_to list_confirm_admin_items_url, notice: 'Статус заказа успешно обновлен.' }
           format.json { head :no_content }       
        end
    end
  end

  def list_payments
    @list_payments_all =  Payment.paginate page: params[:page_payments_all], order: 'created_at desc',
    per_page: 30
    @list_payments_nacc =  Payment.where( status: [ 0 ] ).paginate page: params[:page_payments_nacc], order: 'created_at desc',
    per_page: 30
    @list_payments_problem =  Payment.where( status: [ 2 ] ).paginate page: params[:page_payments_problem], order: 'created_at desc',
    per_page: 30
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def list_lotts
    @list_lotts =  Lott.where( status: 0 ).paginate page: params[:page_lotts], order: 'lot_number desc',
    per_page: 30
    respond_to do |format|
      format.html
      format.js
    end
  end
  def list_lotts_all
    @list_lotts =  Lott.paginate page: params[:page_lotts], order: 'created_at desc',
    per_page: 30
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def list_items
    @items =  Item.where( status: 7 ).paginate page: params[:page_items], order: 'created_at desc',
    per_page: 60
    respond_to do |format|
      format.html
      format.js
    end
  end   
  
  def na_sklade # Заказ поступил на склад
    @item = Item.find(params[:id])
    @item.update_attributes( status: 8 )
    AdminNotify.nasklade(@item).deliver
    redirect_to items_url, notice: 'Статус заказа успешно обновлен.'
  end
  
  def user_search # Поиск пользователя
    @user = User.usearch(params[:search])
      respond_to do |format|
        format.html
        format.js
      end
  end
  def user_card # Карточка пользователя
    @user = User.find(params[:id])
    #************************ Определение переменных для вкладок
    @user_payments = @user.payments.paginate page: params[:payments_param], order: 'created_at desc',
    per_page: 20
    @user_items = @user.orders.paginate page: params[:items_param], order: 'created_at desc',
    per_page: 20
    @user_lotts = @user.lotts.paginate page: params[:page_param], order: 'created_at desc',
    per_page: 20
    #************************ 
    
    #************************ Подсчет итоговых значений
    @user_payments_total = @user_orders_total = @user_lotts_total = 0
    @user.payments.where( status: 1 ).each do |user_total| 
      @user_payments_total += user_total.value
    end
    # where(['user_id = ? AND author_id <> ?', current_user.id, current_user.id])
    @user.orders.where([ 'status <> ? AND status <> ? AND status <> ? ', 0, 1, 9 ] ).each do |order_total| 
      @user_orders_total += order_total.order_value
    end
    @user.lotts.where([ 'status <> ? AND status <> ? AND status <> ? ', 0, 1, 9 ] ).each do |lotts_total| 
      @user_lotts_total += lotts_total.value
    end
      respond_to do |format|
          format.html
          format.js
    end
   end
end 
  
