AnnotateTheBastards::Application.routes.draw do
  # root :to => "welcome#index"
  match 'books/:slug' => 'books#index'
end
