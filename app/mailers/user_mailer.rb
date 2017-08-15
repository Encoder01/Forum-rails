class UserMailer < ActionMailer::Base
  
  default from: '"Forum" <from@example.com>'
  
  def registration_confirmation(user)
    @user = user
    mail to: user.email, subject: "Kayıt onay"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Parola Sıfırlama"
  end
  
end
