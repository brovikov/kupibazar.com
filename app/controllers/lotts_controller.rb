# -*- encoding : utf-8 -*-
class LottsController < ApplicationController
    load_and_authorize_resource #cancan

  def show
    @lott = Lott.find(params[:id])
  end
  
  def index
    @lott= current_user.lotts.paginate page: params[:page_full], order: 'created_at desc',
    per_page: 3
    @lott_acc= current_user.lotts.where( status: 2 ).paginate page: params[:page_acc], order: 'created_at desc',
    per_page: 3
    @lott_nacc= current_user.lotts.where( status: 0 ).paginate page: params[:page_nacc], order: 'created_at desc',
    per_page: 3

    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @lott = Lott.new
#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @product }
  end
  
  def create
      @lott = current_user.lotts.build ( params[:lott] )
    respond_to do |format|
       if @lott.save
         format.html { redirect_to @lott, notice: 'ЛОТ успешно добавлен и ожидает подтверждения.' }
         format.json { render json: @lott, status: :created, location: @lott }
      else
         format.html { render action: "new" }
         format.json { render json: @lott.errors, status: :unprocessable_entity }
      end
    end  
  end
  
  def destroy
    @lott = Lott.find(params[:id])
    respond_to do |format|
      if @lott.status==0 
        @lott.destroy
        format.html { redirect_to lotts_url, notice: 'ЛОТ удален!' }
        format.json { head :no_content }
      
      else
        format.html { redirect_to lotts_url, notice: 'Удаление ЛОТА недоступно!' }
        format.json { head :no_content }
      end
    end    
  end
    
    def edit
     @lott = Lott.find(params[:id])
    end
  
   def update
     @lott = Lott.find(params[:id])

    respond_to do |format|
      if @lott.update_attributes(params[:lott]) 
        format.html { redirect_to @lott, notice: 'ЛОТ успешно обновлен.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lott.errors, status: :unprocessable_entity }
      end
    end
  end

    def status
    @lott = Lott.find(params[:id])
    respond_to do |format|
      if @lott.update_attributes(status: 2) 
        @lott.user.update_attributes(balance: @lott.user.balance - @lott.value)
        if @lott.user.balance < 0
          AdminNotify.dolzhnik(@lott.user).deliver
        end 
        format.html { redirect_to list_lotts_admin_items_url, notice: 'Статус ЛОТА успешно обновлен.' }
          format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
  
      end
    end      
  end
end
