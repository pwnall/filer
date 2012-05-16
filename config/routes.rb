Filer::Application.routes.draw do
  resources :users
  
  resources :devices do
    resources :blocks, controller: 'DeviceBlocks'
  end

  resources :nodes

  authpwn_session
  config_vars

  root :to => 'session#show'
end
