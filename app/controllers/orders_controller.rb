# -*- encoding : utf-8 -*-
class OrdersController < ApplicationController
  load_and_authorize_resource #cancan
  # для получения контента через http
  require 'open-uri'
  # подключаем Nokogiri
  require 'nokogiri'
  include ApplicationHelper
   # before_filter :authenticate_user!
 
  def index
    @order= current_user.orders.paginate page: params[:page_full], order: 'created_at desc',
    per_page: 20
    @order_acc= current_user.orders.where( status: 1 ).paginate page: params[:page_acc], order: 'created_at desc',
    per_page: 20
    @order_nacc= current_user.orders.where( status: 0 ).paginate page: params[:page_nacc], order: 'created_at desc',
    per_page: 20
    @order_buyed= current_user.orders.where( status: 7 ).paginate page: params[:page_nacc], order: 'created_at desc',
    per_page: 20

    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @order = Order.new
    @order.items.build
  end
  
  def edit
    @order = Order.find(params[:id])
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
    def update
      @order = Order.find(params[:id])
      if @order.update_attributes(params[:order])
        @order.save
        flash[:notice] = "Заказ успешно обновлен."
        redirect_to @order
    else
      render :action => 'edit'
    end
  end
  
    def destroy
      @order = Order.find(params[:id])
      @order.destroy
      flash[:notice] = "Заказ успешно удален."
      redirect_to orders_url
  end
  
  def create
    
    @order = current_user.orders.build ( params[:order] )
    #@order.items.each do |img|   
    #   doc = Nokogiri::HTML(open(img.link))
    #   img.img = doc.css('meta')[7]['content']
    #  
    #end
    respond_to do |format|
      if @order.save
        @order.update_attributes( order_value: (@order.items.to_a.sum{|ttl| price(ttl, @order.user)[:val]}).round( 2 ) )
        format.html { redirect_to @order, notice: 'Ваш заказ успешно добавлен и ожидает подтверждения.' }
         format.json { render json: @order, status: :created, location: @payment }
      else
         format.html { render action: "new" }
      end
    end  
  end

  def pay_for                                            # Нажатие кнопки оплатить в заказе
    @order = Order.find(params[:id])
    if @order.status <2 
      pay_for_value = 0
       @order.items.each do |item|
         if item.status < 2
           pay_for_value += price( item, item.order.user )[:val].round( 2 )
         end 
       end 
         blnc = (current_user.balance - pay_for_value).round( 2 )
       if blnc >= 0
            @order.items.each do |item|  
                  if item.status < 2
                      item.update_attributes( status: 2, value_total: (price( item, item.order.user )[:val]).round( 2 ) )
                  end
                  
            end
            current_user.update_attributes( balance: blnc.round( 2 ) )
            @order.update_attributes( status: 2 )             # Статус 2 - "ОПЛАЧЕН"
            redirect_to orders_url, notice: "Статус заказа успешно обновлен. С вашего баланса списано #{pay_for_value} #{@order.user.configApp.currency} "
       else 
            redirect_to orders_url, notice: 'Недостаточно средств на Вашем балансе.' 
       end      
    else
      redirect_to orders_url, notice: 'Оплачивать дважды??! Странновато! :) Конечно же мы против :).' 
    end 
  end
end
