class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :signed_in?, :current_user
  private
  
  def login(user)
=begin
session değikenimizin user idisine
 user değişkenimizinden gelen id değerini atadık.
=end
    session[:user_id] = user.id
  end
  
  def current_user
=begin
session değişkenimizi kontrol edip eğer bir id var ise
 bu idyi user tablosundan bulup örnek değişkenimiz olan current_user'a atadık.
=end
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def signed_in?
 #burada ise görünüm kısımlarında kullanıcı girişi
 #olup olmadığını kontrol etmek için yeni bir yardımcı metod tanımladık
    current_user
  end
  
  def validate_user!
    #eğer kullanıcı girişi yok ise oturum_ac sayfasına yönlendirilecektir
    unless signed_in?
      redirect_to login_url, alert: 'Bu sayfaya erişmeden önce oturum açmalısınız'
    end
  end
  
  def validate_permission!(user)
    #eğer şimdiki kullanıcı ile konu açan veya kullanıcı profiline
    # sahip user eşit değilse anasayfa yönlendirilip bildirim gösterilecek
    unless current_user = user
      redirect_to root_url, alert:  'Bu işlemi gerçekleştiremezsiniz.'
    end
  end
  
end
