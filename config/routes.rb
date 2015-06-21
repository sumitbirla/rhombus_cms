Rails.application.routes.draw do
  
  get 'articles/show'
  get 'articles' => 'articles#index'

  get 'faq/:slug' => 'faqs#category'
  get 'faq' => 'faqs#index'
  get 'pages/:slug' => 'pages#show'
  get 'categories/:slug' => 'categories#show'
  get 'articles/:slug' => 'articles#show'
  get 'articles' => 'articles#index'
  get 'photo_albums/:slug' => 'photo_albums#show'
  get 'photo_albums' => 'photo_albums#index'
  
  namespace :account do
    resources :pictures
    resources :locations do
      member do
        get 'primary' => 'locations#primary'
      end
    end
  end
  
  namespace :admin do
    
    namespace :cms do
      resources :articles do
        member do
          get 'pictures' 
          get 'categories' 
          post 'categories' => 'articles#create_categories'
        end
      end
      resources :pages
      resources :content_blocks
      resources :menus
      resources :menu_items
      resources :regions
      resources :locations do
        member do
          get 'pictures'
          get 'categories'
          get 'attributes'
          get 'sublocations'
          get 'formatted'
          post 'categories' => 'locations#create_categories'
          post 'attributes' => 'locations#create_attributes'
        end
      end
      resources :photo_albums do
        member do
          get 'pictures' => 'photo_albums#pictures'
        end
      end
      resources :pictures do
        member do
         get 'moveup' => 'pictures#moveup'
         get 'movedown' => 'pictures#movedown'
        end
      end
      resources :attributes
      resources :comments
      resources :votes
      resources :filemanager
      resources :faqs
    end
    
  end
  
end
