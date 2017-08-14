module ApplicationHelper
  #kod tekrarından kaçınmak için ve hata gösterimi yapmak için yardımcı metod oluşturduk
  def hata_mesaji_goster(message="Geçerli Bir Değer Giriniz.")
    ['<small class="error">',message,'</small>'].join.html_safe
  end
end
