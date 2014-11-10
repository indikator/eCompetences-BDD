Rails.application.routes.draw do
  get 'site/index'

  get 'signin', to: 'session#index'

  get 'logout', to: 'session#destroy'

  root 'site#index'
end
