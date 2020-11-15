Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles do 
    resources :comments 
  end
  
  root 'pages#home'
  
  get 'about' , to: 'pages#about'

  resources :articles , only:[:show , :index , :new , :create , :edit , :update , :destroy]

  get 'signup' , to: 'users#new'

  resources :users, except: [:new]
  
  get 'login' , to:'sessions#new'
  post 'login' , to:'sessions#create'
  delete 'logout' , to:'sessions#destroy'

  resources :categories , except: [:destroy]

 

  
end
