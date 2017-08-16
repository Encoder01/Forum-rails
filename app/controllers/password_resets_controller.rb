class PasswordResetsController < ApplicationController
  
  #ilk başta kullanıcıdan gelen email ait tabloyu bulduk
  #if kontrolünde eğer bir email var ise kullanıcıya mailer ile linki yolladık.
  #ardından anasayfaya yönlenddirdik.
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email adresinize parola sıfırlama linki gönderildi."
  end
  #parolayı sıfırlayabilmesi için geln linkin parametresinden idye ait tokeni bulduk.
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  #kullanıcı parolayı sıfırlamak isterse tokenin oluşturma tarihine baktık
  #2 saatin altında ise gelen parametrede şifreyi güncelledik.
  #aksi durumda yeniden edit sayfasına yönlendirdik.
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "Parolanız geçerlilik süresi doldu."
    elsif @user.update(user_params)
      redirect_to root_url, notice: "Parolanız başarıyla sıfırlandı!"
    else
      render :edit
    end
  end
  
  private
#tabloda kullanıcın değiştirebilmesine izin verdiğimiz alanı ayarlıdık.(parola)
  def user_params
    params.require(:user).permit(:password)
  end
end
