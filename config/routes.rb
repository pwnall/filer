Filer::Application.routes.draw do
  resources :users
  
  resources :devices, except: [:edit] do
    get '/blocks(.:format)' => 'device_blocks#index', as: :blocks
    post '/blocks(/:count)(.:format)' => 'device_blocks#create'
    delete '/blocks(/:count)(.:format)' => 'device_blocks#destroy'
  end

  resources :nodes

  authpwn_session
  config_vars

  root :to => 'session#show'
end
