Rails.application.routes.draw do
  #parola sıfırlama rotaları türkçe yapma
  get 'parola/yeni', to: 'password_resets#new'
  get 'parola/sifirla', to: 'password_resets#edit'
  
  #forumlar şeklinde değiştirdik
  get 'forumlar', to: 'forums#index', as: :forums
  get 'forumlar/:id', to: 'forums#show', as: :forum

  #sessions oturum şeklinde değiştirdik
  get    '/oturum_ac',     to: 'sessions#new',     as: :login
  delete '/oturumu_kapat', to: 'sessions#destroy', as: :logout
  
  # user/new rotasını kaydol diye değiştirdik
  get '/kaydol', to: 'users#new', as: :register
  get '/users/new', to: redirect('/kaydol')
  
  #user/id ve edit rotasını kullanici_adi şeklinde değiştirdik
  get '/:id', to: 'users#show', as: :profile
  get '/:id/edit', to: 'users#edit' ,as: :edit_profile
  
  #oturum için gerekli rotaları ekledik
  resource :session, only:[:new,:create,:destroy]
  #index metodu için rota oluşturmasını engelledik
  resources :users, except: :index

  resources :forums, only:[:index,:show], path: 'forumlar' do
    resources :topics,only:[:new,:create], path: 'konular', path_names: {new: 'yeni'}
  end
  
  resources :password_resets, path_names: {new: 'yeni' ,edit: 'duzenle'}
  resources :topics, except: [:index, :new, :create],
      path: 'konular', path_names: {edit: 'duzenle'}
  
  root 'forums#index'
  
  
  
  
  
end
