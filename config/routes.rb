AnnotateTheBastards::Application.routes.draw do
  root :to => "home#index"
  
  resources :books, :only => [:index] do
    resources :annotations, :only => [:index, :show]
  end
end
