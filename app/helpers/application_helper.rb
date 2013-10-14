module ApplicationHelper
  def price (value, currency, count)
    val_first = value
    c = case
      when currency == 'usd' then 1
      when currency == 'rub' then 35.3
    end  
    value = value*count    
    if value > 10 
      value = (value*10/100 + value)
      curr_str = count.to_s + " x " +  val_first.to_s + " +10% = $" + value.round( 2 ).to_s  
      else 
        value += 1
        curr_str = count.to_s + " x " +  val_first.to_s + "+$1 = $" + value.round( 2 ).to_s  
      end
    result = value*c
    
    {val: result.round( 2), str:curr_str}
  end

  
end
