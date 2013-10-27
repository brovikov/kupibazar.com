module ApplicationHelper
  def price (item, currency )
    val_first = item.value
    c = case
      when currency == 'usd' then 1
      when currency == 'rub' then 35.3
    end  
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
    
    {val: result.round( 2), str:curr_str}
  end

  
end
