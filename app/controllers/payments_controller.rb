class PaymentsController < ApplicationController
  def show
    @payment = Payment.find(params[:id])
  end
  
  def index
    @payment= current_user.payments.all
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
end
