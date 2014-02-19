# -*- encoding : utf-8 -*-
module ApplicationHelper
  def price ( item, user )
    val_first = item.value
    c = user.configApp.rate
      value = item.value*item.count    
      if item.havy 
        percent = 20
        str_per = "20%"
      else 
        percent = 10
        str_per = "10%"
      end
      if value > 0             
        if value > 10 
          value = (value*percent/100 + value)
          curr_str = item.count.to_s + " x " +  val_first.to_s + " + " + str_per + " = $" + value.round( 2 ).to_s  
        else 
          value += 1
          curr_str = item.count.to_s + " x " +  val_first.to_s + "+$1 = $" + value.round( 2 ).to_s  
        end
      else                     
        value = 0
        curr_str = ""
      end 
    result = value*c.round( 2 )
    
    {val: result.round( 2 ), str:curr_str}
  end

  def order_stat (status) # Статусы заказа
    case
      when status == 0 
        '<span class="label label-warning"> На согласовании </span>'.html_safe
      when status == 1 
        '<span class="label label-success"> Подтвержден </span>'.html_safe
      when status == 2 
        '<span class="label label-success"> Оплачен </span>'.html_safe
      when status == 9 
        '<span class="label label-important"> Отклонен </span>'.html_safe
      when status == 7 
        '<span class="label label-success"> Выкуплен </span>'.html_safe
      when status == 8 
        '<span class="label label-success"> На складе </span>'.html_safe
      when status == 3 
        '<span class="label label-success"> Бронь </span>'.html_safe
      when status == 5 
        '<span class="label label-success"> Выдан </span>'.html_safe
      end    

  end

  def stat (status) # Статусы платежей
    case
      when status == 0 
        '<span class="label label-warning"> На согласовании </span></br>'.html_safe
      when status == 1 
        '<span class="label label-success"> Подтвержден </span></br>'.html_safe
      when status == 2 
      '<span class="label label-important"> Проблемный </span></br>'.html_safe
      end    
  end

  def order_val( order )
    order_vals = 0
    order.items.each do |item|
      if item.status < 2
      order_vals += price( item, item.order.user)[:val].round( 2 )
      else
        order_vals += item.value_total
      end
    end
    order.update_attributes( order_value: order_vals )
  end



end
