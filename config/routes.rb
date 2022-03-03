Rails.application.routes.draw do
  devise_for :users,
  controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'users/current', to: 'users#show'
  end

  scope 'api' do
    resources 'movies'
    resources 'casts'
    resources 'genres'
    resources 'reviews'
    #FrontEnd API
    get 'home', to: 'page#home'
    get 'movie-list', to: 'page#movie_list'
    post 'add-remove-favorite', to: 'favorites#add_remove_favorite'
    get 'user-favorites', to: 'favorites#favorites'
    post 'quick-search', to: 'page#quick_search'
    get 'movie-reviews', to: 'page#movie_reviews'
  end
end
