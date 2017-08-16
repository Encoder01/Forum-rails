class User < ApplicationRecord
  has_secure_password #bcrypt gemini kullanabilmek için
  before_create :confirmation_token
  has_many :topics, dependent: :destroy#foruma ait konu silinir ise o
  # tabloyla ilişkili her şeyi sildik.

  
  validates :username, presence: true,#kullanıcı adı boş bırakılmaz
                       exclusion: {in:['oturum_ac']},#oturum_acı hariç tuttuk
                       uniqueness: {case_sensitive: false},#benzersiz ve harf duyarlılığı false yaptık.
                       length: {in: 4..12},#uzunluk 4 ila 12 arası
                       format: {with: /\A[a-zA-Z][a-zA-Z0-9_-]*\Z/ }
  validates :first_name, presence: true#isim boş bırakılmaz.
  validates :last_name, presence: true#soyisim boşbırakılmaz.
  validates :email, presence: true,#email boş bırakılmaz.
                    uniqueness: {case_sensiteve: false},#benzersiz ve harf duyarlılığı false.
                    email: true
 #parola sıfırlama göndermek için metod oluşturduk.
  #ilgili tablomuza generate_tokene parametre göndererek doldurduk.
  #ve zaman bilgisini de ekledik
  #kaydedip kullanıcıya linki gönderdik.
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now
  end
  #parola sıfırlama için yeni bir token oluşturduk ve parametre almasını sağladık
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def name
    #profil ismi göstermek için metod tanımladık
    "#{first_name} #{last_name}"
  end

  def avatar_url(size = 160)
    hash_value = Digest::MD5.hexdigest(email.downcase)
    "http://www.gravatar.com/avatar/#{hash_value}?s=#{size}"
  end
#user kontrollerinde kullanmak için email tablosunu falsedan truye çevirdik ve tokeni sıfırladık.
  def email_activate
    self.confirm_email = true
    self.confirm_token = nil
    save!(:validate => false)

  end
  
  def to_param
    #user/id değeri yerine RoR kendi içinde barındırdığı kullanıcı adı ile çağırmak için metodu aktif ettik
    username
  end

  private
# email onayı için base64 ile bir url oluştruduk
  #bunu cınfirm_token kolonuna kaydettik
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
  
    end
  end
  
end
