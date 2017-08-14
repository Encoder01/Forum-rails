class SessionsController < ApplicationController
  def new
  end

  def create
=begin
    user adında bir değişken tanımladık.
    tanımladığımız değişkenin User tablosunda usernmame ile
    formdan gelen username eşit olan değeri bulduk.
=end
    user = User.find_by_username(params[:session][:user_name])
    
=begin
    if kontrolunde user değişkenimiz eğer bir true değer döndürürse
 ve ardından user değişkenin formdan gelen parola değeri ile eşleşirse
  kullanıcı girişi yapmasını sağladık.
=end
    if user && user.authenticate(params[:session][:password])
      login(user)
      redirect_to profile_path(user), notice: "Oturum Açıldı."
    else
      flash[:error] = "Kullanıcı Adı veya Parola Hatalı."
      redirect_to login_url
    end
  end

  def destroy
=begin
  session değişkenimize boş bir değer atayarak
  var olan user idyi sıfırlamış olduk böylece oturum sonlandı.
=end
    session[:user_id] = nil
    redirect_to login_path, notice: "oturumunuz sonlandırıldı."
  end
end
