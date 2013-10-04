class OrdersController < ApplicationController
  # для получения контента через http
  require 'open-uri'
  # подключаем Nokogiri
  require 'nokogiri'
  
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
        flash[:notice] = "Successfully updated order."
        redirect_to @order
    else
      render :action => 'edit'
    end
  end
  
    def destroy
      @order = Order.find(params[:id])
      @order.destroy
      flash[:notice] = "Successfully destroyed order."
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
        format.html { redirect_to @order, notice: 'Ваш заказ успешно добавлен и ожидает подтверждения.' }
         format.json { render json: @order, status: :created, location: @payment }
      else
         format.html { render action: "new" }
         format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end  
  end
end
