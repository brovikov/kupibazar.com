# -*- encoding : utf-8 -*-
class PaymentNotify < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.payment_notify.received.subject
  #
  def received (payment)
    @payment = payment

    mail to: payment.user.email, subject: "Подтверждение пополнения баланса на kupibazar.com"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.payment_notify.problem.subject
  #
  def problem (payment)
    @payment = payment

    mail to: payment.user.email, subject: "Ууупс, проблема с подтверждением Вашего платежа на kupibazar.com"
  end
end
