AnnotateTheBastards::Application.routes.draw do
  root :to => "books#index"
  
  resources :books, :only => [:index, :show] do
    resources :annotations, :only => [:index, :show]
  end
end
