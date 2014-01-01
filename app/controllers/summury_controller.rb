class SummuryController < ApplicationController
  def totals
    @user_cnt = @user_blc = @item = @item_cash = @item_lm = @item_cash_lm = @item_lm1 = @item_cash_lm1 = 0
    User.all.each do |user|
      @user_cnt += 1
      @user_blc += user.balance
    end
    Item.where( status: [ 7, 8 ]).each do |item| # Всего оформлено заказов
      @item += item.value
      if item.value < 10 
        @item_cash += 1
      else
        @item_cash += item.value*10/100 
      end
    end
    Item.where( status: [ 7, 8 ], created_at: (Time.now.midnight - 1.month)..Time.now.midnight).each do |item| # Всего оформлено заказов за последний месяц
      @item_lm += item.value
      if item.value < 10 
        @item_cash_lm += 1
      else
        @item_cash_lm += item.value*10/100 
      end
    end
      Item.where( status: [ 7, 8 ], created_at: (Time.now.midnight - 2.month)..(Time.now.midnight- 1.month)).each do |item| # Всего оформлено заказов за последний месяц
      @item_lm1 += item.value
      if item.value < 10 
        @item_cash_lm1 += 1
      else
        @item_cash_lm1 += item.value*10/100 
      end
    end
  end
end
