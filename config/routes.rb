Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }

  namespace 'api' do
    namespace 'v1' do
      post '/charge-customer', to: 'payments#charge'
      get '/blogs/search', to: 'blogs#search_blogs'
      resources :blogs
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
