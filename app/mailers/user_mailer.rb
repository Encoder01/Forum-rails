class UserMailer < ApplicationMailer
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Parola Sıfırlama"
  end
  
end
