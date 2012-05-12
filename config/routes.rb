Filer::Application.routes.draw do
  resources :devices

  resources :nodes

  authpwn_session
  config_vars

  root :to => 'session#show'
end
