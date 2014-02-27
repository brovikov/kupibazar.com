class LotsController < ApplicationController
    include ApplicationHelper
  def new
    @lot = Lot.new
    @lot.lotitems.build
  end
  
  def create
    
    @lot = Lot.new( params[:lot] )
    @lot.moderator = current_user.id
    
    @forum = Forum.find( 1 )  # Создаем новый топик на форуме id=1
    @topic = @forum.topics.build( title: @lot.name , body: 'Автоматически созданный топик'  )
    @topic.user = current_user
    @topic.save
    @lot.topic_id = @topic.id
    
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
    sts = 1
    @lotitem.update_attributes( user_id: current_user.id, color: t[:color], comment: t[:comment], status: 3 )
    @lotitem.lot.lotitems.each  do |item| 
      if item.status == 3 
        sts = 3
      else
        sts = 1
        break
      end
    end
    @lotitem.lot.update_attributes( status: sts )   
    redirect_to @lotitem.lot, notice: 'Бронирование выполненно успешно!' 
  end 
  
  def debook
    sts = 1
    @lotitem = Lotitem.find(params[:l_param])
    @lotitem.update_attributes( user_id: 0, color: nil, comment: nil, status: 1 ) 
       @lotitem.lot.lotitems.each  do |item| 
      if item.status == 3 
        sts = 3
      else
        sts = 1
        break
      end
    end
    @lotitem.lot.update_attributes( status: sts ) 
    redirect_to @lotitem.lot, notice: 'Бронирование аннулированно.' 
  end 
  
  
end
