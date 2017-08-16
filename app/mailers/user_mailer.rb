class UserMailer < ActionMailer::Base
  
  default from: '"Forum" <from@example.com>'
  #email onay için kullanıcın emailine link gönderme
  def registration_confirmation(user)
    @user = user
    mail to: user.email, subject: "Kayıt onay"
  end
#parola sıfırlama için kullanıcın emailine link gönderme
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Parola Sıfırlama"
  end
  
end
