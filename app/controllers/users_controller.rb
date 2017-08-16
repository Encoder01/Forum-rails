class UsersController < ApplicationController
  #şuanki kullanıcı için kendi profilindeki yapabilceği eylemleri tanımladık.
  #profil düzenleme, silme ve başkaların profilini görme.
  before_action :select_user , only: [:show,:edit,:update,:destroy]
  
  before_action  only: [:edit, :update, :destroy] do
    validate_permission! select_user
    #eğer şuanki kullanıcıdan bir başkası veya oturum
    # açmamış biri ise eylemleri erişime engelledik.
  end
  
  
  
  def new
# yeni bir kullanıcı oluşturmak için göürünüm kısmından
# new.html çalışmasını sağlamak için bir metod oluşturduk.
    @user= User.new
  end
  
  def create
  #new metodumuzdan gelen form değerlerinin kaydedebilmemiz için oluşturduğumuz metod
    @user = User.new(user_params)#formdan gelen değerleri User tablosuna yansıttık
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      #eğer işlem kaydedilirse kullanıcı girişi yapıp bildirim gösterdik
      login(@user)
      flash[:notice] = "Aramıza Hoşgeldin"
      redirect_to profile_path(@user), notice: "Aramıza Hoşgeldin."
    else
      render 'new'#aksi takdirde yeniden new görünümünü yükle
    end
  end

  
  #email onayı için bir metod oluşturduk.
  #gelen token parametresinden idyi bulup eşit kullanıcıyı değişkene aktardık
  #burdan email_activate metoduna yönlendirdik/çağırdık.(model/user)
  #ardından bildirim ile kullanıcıya gösteridk.
  #eğer eşit kullanıcı yoksa hata bildirimi gösterdik.
  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:succes] = "email onaylandı"
      redirect_to root_url
    else
      flash[:error] = " bir hata ile karşılandı"
    end
  end
  
  def show
    #kullanıcı profilinde sayfa parametresine eğer konular eşleşir ise.
    #kullanıcın açtığı konuları kendi profilinde listeledik.
    
    #listelemek için bir data örnek değişkeni oluşturduk
    #değişkenimize konular tablosundan kullanıcı id'isine eşit olan konuları aktardık
    #aksi durumda değişkeni sıfırladık.
    sayfa = params[:sayfa]
    if sayfa == 'konular'
      @data = @user.topics
    else
      @data = []
    end
      render layout: 'profile', locals: {page: 'konular'}
    end
  
  def edit
    #profil düzenlemesini yapmak için ve görünümler
    # kısmında gözükmesi için edit metodumuzu oluşturduk
    render layout: 'profile'
  end
  
  def update
    #formdan gelen değerleri update_user değişkeninde tuttuk
    update_user = user_params
    
    if update_user.has_key?(:password)
      #güvenlik amaçlı eğer bilinçli olarak bir
      # kullanıcı password_field alanı oluşturup değiştirmek
      # isterse kontrol edip bu alanı sildik
      update_user.delete([:password,:password_confirmation])
    end
    
    if @user.update(update_user)
      #ve burada değişkenimizdeki değerleri User tablosuna yansıttık
      flash[:notice] = "Profiliniz Güncelledndi"
      redirect_to profile_path(@user), notice: "Profiliniz Güncellendi"
    else
      render :edit, layout: 'profile'
    end
    
  end
  
  def destroy
    #kullanıcı hesabını silmek isterse Tablodan silme işlemini gerçekleştirdik
    @user.destroy
    redirect_to '/'
  end
  
  
  
  private
  
  
  def select_user
    #parametremizden gelen kullanıcı id'iye ait kullanıcı_adını örnek değişkenimize atadık.
    @user = User.find_by_username(params[:id])
  end
  
  def user_params
    #create ve update metodlarında tekrardan kaçınmak için özel bir metod oluşturduk
    params.require(:user).permit!#create ve update yapabilmesi
    # için bir kullanıcı değeri aldık ve tüm yetkilere izin verdik
  end
end
