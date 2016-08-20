Rails.application.routes.draw do
  devise_for :users
  root to: 'surveys#index'
end
