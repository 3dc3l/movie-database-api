Rails.application.routes.draw do
  devise_for :users,
  controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'users/current', to: 'sessions#show'
  end

  scope 'api' do
    resources 'movies'
    resources 'casts'
    resources 'genres'
    resources 'reviews'
  end
end
