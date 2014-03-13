module LotsHelper
  def find_user( user )
    User.find( user ).nik
  end
  
  def lot_price( lot, user ) 
    total = 0
    pcn = 0.1 # Стандартный процент 10%
    cfc = 1 # стандартный коэффициент для лотов дешевле 10 долларов - 1 доллар
    if lot.moderator == user.id
      pcn = 0.05
      cfc = 0.5
    end
      
    if user.configApp.id < 2
# --- Расчет для Приднестровья ------
          if lot.value < 10 
            total = ( lot.value + cfc )*user.configApp.rate
          else # если лот дороже 10 долларов
            if lot.havy
              total = ( lot.value + lot.value*pcn*2 )*user.configApp.rate
            else 
              total = ( lot.value + lot.value*pcn )*user.configApp.rate
            end
          end
    else
# --- Расчет для Одессы ------      
      total = ( lot.value + lot.value*pcn )*user.configApp.rate
    end
  end
  def total_lot_price( lot, user )
    total = 0
    for l in lot.lotitems do
      if user.id == l.user_id
        total = total + l.value_total
      end
    end
     total
  end

  def cat_path
      a = Catalogitem.where( id: @lot.catalog_id ).first.catalog.title
      b = Catalogitem.where( id: @lot.catalog_id ).first.line 
      c = a + ' > ' + b
  end
   
    
end
