Rails.application.routes.draw do
  devise_for :users, path: '',
             defaults: { format: :json },
             path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
             },
             controllers: {
                 sessions: 'auth/sessions',
                 registrations: 'auth/registrations'
             }

  resources :users, defaults: { format: :json }, only: %i[index]
end
