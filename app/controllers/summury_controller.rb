# -*- encoding : utf-8 -*-
class SummuryController < ApplicationController
    authorize_resource :class => false
    include ApplicationHelper
  def totals
    @user_balance = User.where(" balance < '0' ")
    @user_cnt = @user_blc = @item = @item_cash = @item_lm = @item_cash_lm = @item_lm1 = @item_cash_lm1 = 0
    @lott = @lott_cash = @lott_lm = @lott_cash_lm = @lott_lm1 = @lott_cash_lm1 = 0
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
     Lott.where( status: [ 2 ] ).each do |lott| # Всего оформлено Лотов 
      @lott += lott.value/35.3
      if lott.value < 350.3 
        @lott_cash += 1
      else
        @lott_cash += lott.value*10/100/35.3 
      end
    end  
     Lott.where( status: [ 2 ], created_at: (Time.now.midnight - 1.month)..Time.now ).each do |lott| # Всего оформлено Лотов за последний месяц
      @lott_lm += lott.value/35.3
      if lott.value < 350.3 
        @lott_cash_lm += 1
      else
        @lott_cash_lm += lott.value*10/100/35.3 
      end
    end  
      Lott.where( status: [ 2 ], created_at: (Time.now.midnight - 2.month)..(Time.now.midnight- 1.month) ).each do |lott| # Всего оформлено Лотов за предыдущий месяц
      @lott_lm1 += lott.value/35.3
      if lott.value < 350.3 
        @lott_cash_lm1 += 1
      else
        @lott_cash_lm1 += lott.value*10/100/35.3 
      end
    end  
  end
    def dolzhnik_notify
      AdminNotify.dolzhnik(User.find(params[:id])).deliver
      redirect_to totals_summury_url, notice: 'Уведомление об отрицательном балансе отправлено'
    end 
end
