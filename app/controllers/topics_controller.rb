class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy] do
    validate_permission!(set_topic.user)
  end
  before_action :validate_user!, except: [:show]
  
  
  def index
    #konuları anasayfada göstermek için tüm konuları çektik.
    @topics = Topic.all
  end

  #show görümümüzün çalışmasını sağlamak için metod tanımladık.
  def show
  end

  
  def new
    #yeni bir konu açmak iiçin öncelikle forum kategorisini bulduk
    @forum = Forum.find(params[:forum_id])
    #ardından formdan gelen değerleri topic tablomuzda oluşturduk.
    @topic = @forum.topics.new
  end

  #edit görünümümüzü açmak için bir metod oluşturduk.
  def edit
  end

  
  def create
    #öncelikle forumlardan kategoriyi bulduk
    @forum = Forum.find(params[:forum_id])
    #ardından izin verilen kısımlara konular tablosunu kaydettik.
    @topic = @forum.topics.new(topic_params)
    #ve konuyu oluşturan useri şimdiki kullanıcı ile eşleştirdik.
    @topic.user = current_user
    
    #eğer konu kaydedildi ise bildirim gösterip konuya yönlendirdik.
    if @topic.save
    redirect_to @topic, notice: 'Konu Başarıyla oluşturuldu.'
    
    else
      #aksi durumda sayfayı yeniden yükledik.
        render :new
      
    end
  end

  
  def update
    #konu güncellemesi olduğu takdirde
    # parametremizden gelen değerleri veri tabanımıza yeniden kaydettik.
      if @topic.update(topic_params)
         redirect_to @topic, notice: 'Konu başarıyla Güncellendi.'
        
      else
        render :edit
        
      end
  end

 
  def destroy
    #konu silme isteği geldiğinde konumuzu db'den sildik.
    @topic.destroy
    redirect_to topics_url, notice: 'Konu başarıyla silindi.'
    
    end

  private
    #burada özel yardımcı metodlar tanımladık
    
  def set_topic
    #sunucudan gelen id isteğine göre konular tablomuzdan id değeri ile eşleşen kolonu bulduk.
      @topic = Topic.find(params[:id])
    end

    
    def topic_params
      #burada gerekli parametreleri ayarladık
      #konular tablosuna sadece başlık ve içerik oluşturma ve güncellemeye izin verdik.
      params.require(:topic).permit(:title, :body)
    end
end
