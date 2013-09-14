module PaymentsHelper
  def stat (status)
    case
      when status == 0 
      '<span class="label label-warning"> На согласовании </span></br>'.html_safe
      when status == 1 
      '<span class="label label-success"> Подтвержден </span></br>'.html_safe
      end            
  end
end
