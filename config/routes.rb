Rails.application.routes.draw do
	root to: 'welcome#homepage'
	get 'books/search' => 'books#search'
	get 'books/results' => 'books#results'
	post '/listings' => 'listings#create'
	resources :authors, only: [:show, :new, :create] do
		resources :books, only: [:index, :new]
	end 
	resources :books, only: [:show, :new, :create]
	post 'read_books' => 'read_books#create'
	get 'profile' => 'users#current'
	resources :users do 
		resources :books, only: [:index]
	end
	resources :lists
	# get 'lists/:id/add_books' => 'lists#add_books', as: "add_books_path"
	get 'login' => 'sessions#new'
	post 'login' => 'sessions#create'
	get 'logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #NEED TO DO: 
  #- edit your profile
  #- show and new pages for authors
  #- possibly edit pages for authors/books
  #- move forms into partials
end
