class Forum < ApplicationRecord
  #silinen bir Forum var ise bu konuyla iilşkili herşeyi dependent metodu ile sildik.
has_many :topics, dependent: :destroy
  #isimleri benzersiz yaptık.
  validates :name , presence: true, uniqueness: true
  
end
