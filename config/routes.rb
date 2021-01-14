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

  resources :users, defaults: { format: :json }, only: %i[show]
  resources :boards, defaults: { format: :json }, param: :slug, only: %i[index show create]
  resources :cards, defaults: { format: :json }, only: %i[index show create]
  resources :columns, defaults: { format: :json }, only: %i[index create]
end
