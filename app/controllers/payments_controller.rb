# -*- encoding : utf-8 -*-
class PaymentsController < ApplicationController
  def show
    @payment = Payment.find(params[:id])
  end
  
  def index
    @payment= current_user.payments.paginate page: params[:page_full], order: 'created_at desc',
    per_page: 3
    @payment_acc= current_user.payments.where( status: 1 ).paginate page: params[:page_acc], order: 'created_at desc',
    per_page: 3
    @payment_nacc= current_user.payments.where( status: 0 ).paginate page: params[:page_nacc], order: 'created_at desc',
    per_page: 3

    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @payment = Payment.new
#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @product }
  end
  
  def create
      @payment = current_user.payments.build ( params[:payment] )
    respond_to do |format|
       if @payment.save
         format.html { redirect_to @payment, notice: 'Платеж успешно добавлен и ожидает подтверждения.' }
         format.json { render json: @payment, status: :created, location: @payment }
      else
         format.html { render action: "new" }
         format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end  
  end
  
  def destroy
    @payment = Payment.find(params[:id])
    respond_to do |format|
      if @payment.status==0 
        @payment.destroy
        format.html { redirect_to payments_url, notice: 'Платеж удален!' }
        format.json { head :no_content }
      
      else
        format.html { redirect_to payments_url, notice: 'Удаление платежа недоступно!' }
        format.json { head :no_content }
      end
    end    
  end
    
    def edit
     @payment = Payment.find(params[:id])
    end
  
   def update
     @payment = Payment.find(params[:id])

    respond_to do |format|
      if @payment.update_attributes(params[:payment]) 
        format.html { redirect_to @payment, notice: 'Пополнение баланса успешно обновлено.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def status
    @payment = Payment.find(params[:id])
    respond_to do |format|
      if @payment.update_attributes(status: 1) 
        @payment.user.update_attributes(balance: @payment.user.balance + @payment.value)
        format.html { redirect_to list_payments_admin_items_url, notice: 'Статус пополнения баланса успешно обновлен.' }
          format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
  
      end
    end      
  end
end

    
