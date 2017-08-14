class User < ApplicationRecord
  has_secure_password #bcrypt gemini kullanabilmek için
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
 
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now
  end
  
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
    #kullanıcı eğer gravat kullanıyorsa mailinden md5 şifre oluşturarak resmini çekmek için metodumuzu oluşturduk
    hash_value = Digest::MD5.hexdigest(email.downcase)
    "http://www.gravatar.com/avatar/#{hash_value}?s=#{size}"
  end
  
  def to_param
    #user/id değeri yerine RoR kendi içinde barındırdığı kullanıcı adı ile çağırmak için metodu aktif ettik
    username
  end
  
end
