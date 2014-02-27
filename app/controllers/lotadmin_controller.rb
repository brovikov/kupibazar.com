class LotadminController < ApplicationController
  
  
  def lot_for_confirm # Лоты на проверку
    @lot = Lot.where( status: 0 ).paginate page: params[:page_lots], order: 'created_at desc',
    per_page:1
  end 
  def confirmed # Заказ подтвержден -> Статус: 1
    @lot = Lot.find(params[:id])
    @lot.update_attributes( status: 1 )
    redirect_to lot_for_confirm_lotadmin_index_url, notice: 'Статус лота успешно обновлен.'
  end
end
