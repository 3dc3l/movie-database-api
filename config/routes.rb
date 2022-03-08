Rails.application.routes.draw do
  devise_for :users,
  controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'users/current', to: 'users#show'
    get 'users/all', to: 'users#index'
    post 'users/admin-login', to: 'users/sessions#admin_login'
  end

  scope 'api' do
    resources 'movies'
    resources 'casts'
    resources 'genres'
    resources 'reviews'
    get 'genres-and-casts', to: 'page#genres_and_casts'
    get 'movies-data', to: 'page#movie_by_slug'
    
    #FrontEnd API
    get 'home', to: 'page#home'
    get 'movie-list', to: 'page#movie_list'
    post 'add-remove-favorite', to: 'favorites#add_remove_favorite'
    get 'user-favorites', to: 'favorites#favorites'
    post 'quick-search', to: 'page#quick_search'
    get 'movie-reviews', to: 'page#movie_reviews'
  end
end
