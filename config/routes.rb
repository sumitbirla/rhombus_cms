Rails.application.routes.draw do
  
  get '/pages/:slug' => 'pages#show'
  get '/categories/:slug' => 'categories#show'
  
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
      resources :pages
      resources :content_blocks
      resources :menus
      resources :menu_items
      resources :regions
      resources :locations do
        member do
          get 'pictures' => 'locations#pictures'
          get 'categories' => 'locations#categories'
          get 'attributes' => 'locations#attributes'
          get 'sublocations' => 'locations#sublocations'
          get 'formatted' => 'locations#formatted'
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
