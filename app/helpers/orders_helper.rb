module OrdersHelper

  def order_stat (status)
    case
      when status == 0 
        '<span class="label label-warning"> На согласовании </span></br>'.html_safe
      when status == 1 
        '<span class="label label-success"> Подтвержден </span></br>'.html_safe
      when status == 2 
        '<span class="label label-success"> Оплачен </span></br>'.html_safe
      when status == 9 
        '<span class="label label-important"> Отклонен </span></br>'.html_safe
      when status == 7 
        '<span class="label label-success"> Выкуплен </span></br>'.html_safe
      end     
  end
  
end
