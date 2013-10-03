class PurchasesController < ApplicationController
  
  def new
    @purchase = Purchase.new
#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @product }
  end
  
  def create
    @purchase = current_user.purchases.build ( params[:purchase] )
    respond_to do |format|
      if @purchase.save
         format.html { redirect_to @purchase, notice: 'Платеж успешно добавлен и ожидает подтверждения.' }
         format.json { render json: @purchase, status: :created, location: @purchase }
      else
         format.html { render action: "new" }
         format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end  
  end
  
end
