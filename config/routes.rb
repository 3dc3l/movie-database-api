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
    #Home page
    get 'home', to: 'page#home'
  end
end
