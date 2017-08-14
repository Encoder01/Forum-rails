class Topic < ApplicationRecord
  #konulara ait ilişkili tabloları tanımladık
  belongs_to :user
  belongs_to :forum

 
  #başlık ,içerik,kullanıcı ve forum alanlarını boş bırakılmamasını önledik.
  #içeriği ise minumum 20 karakter ile sınırlandırdık.
  validates :title, presence: true
  validates :body, presence: true, length: {minimum: 20}
  validates :user, presence: true
  validates :forum, presence: true
end
