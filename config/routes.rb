Rails.application.routes.draw do
  get 'facebook/index'
  root 'facebook#index'
end
