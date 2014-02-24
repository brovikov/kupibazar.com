class LotsController < ApplicationController
    include ApplicationHelper
  def new
    @lot = Lot.new
    @lot.lotitems.build
  end
  
  def create
    
    @lot = Lot.new( params[:lot] )
    @lot.moderator = current_user.id
      if @lot.save
         redirect_to @lot, notice: 'Ваш лот успешно добавлен и ожидает подтверждения.' 
      else
         render action: "new" 
      end
    end  
  
  def show
    @lot = Lot.find(params[:id])
    
      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lot }
    end
  end
  
  def book
    @lotitem = Lotitem.find(params[:l_param])
    t=params[:lotitem]
    @lotitem.update_attributes( user_id: current_user.id, color: t["color"], comment: t["comment"] )
    #render action: "add_book", remote: true
    redirect_to @lotitem.lot, notice: 'Для окончания бронирования заполните пожалуйста дополнительные данные.' 
  end 
  
  def debook
    @lotitem = Lotitem.find(params[:l_param])
    @lotitem.update_attributes( user_id: 0, color: nil, comment: nil ) 
    redirect_to @lotitem.lot, notice: 'Бронирование аннулированно.' 
  end 
  
end
