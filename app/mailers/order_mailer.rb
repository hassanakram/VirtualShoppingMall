class OrderMailer < ActionMailer::Base
  default from: "info@vsm.com"

  def order_confirmation(user)
    @user = user
    mail(to: @user.email, subject: 'Order Confirmarion')
  end
end
