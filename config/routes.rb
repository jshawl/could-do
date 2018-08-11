Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth', to: "sessions#new", as: :new_session
  get '/auth/callback', to: 'sessions#create'
  get '/:hash.ics', to: 'welcome#ics'
  resource :session
end
