Rails.application.routes.draw do
  devise_for :users,
  controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  scope 'api' do
    resources 'movies'
    resources 'casts'
  end
end
