Filer::Application.routes.draw do
  authpwn_session
  config_vars

  root :to => 'session#show'
end
