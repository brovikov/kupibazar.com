# -*- encoding : utf-8 -*-
class AdminNotify < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_notify.nasklade.subject
  #
  def nasklade (item)
    @item = item

    mail to: item.order.user.email, subject: "Заказ, оформленный Вами на kupibazar.com уже на нашем складе"
  end
end
