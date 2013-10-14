class AdminItemsController < ApplicationController
    include ApplicationHelper
  
  def index
    @items = Item.paginate page: params[:page_full], order: 'created_at desc',
    per_page: 20
    @items_acc= Item.where( status: 1 ).paginate page: params[:page_acc], order: 'created_at desc',
    per_page: 20
    @items_nacc= Item.where( status: 0 ).paginate page: params[:page_nacc], order: 'created_at desc',
    per_page: 20

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
      if @item.update_attributes(status: 1) 
        format.html { redirect_to admin_items_url, notice: 'Статус заказа успешно обновлен.' }
          format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
  
      end
    end      
  end
end
