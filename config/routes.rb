AnnotateTheBastards::Application.routes.draw do
  root :to => "books#index"

  
  resources :books, :only => [:index] do
    resources :annotations, :only => [:index, :show]
  end
  
  match 'books/:book_id/annotations/page/:page_id' => 'annotations#page'
end
