Rails.application.routes.draw do



  root 'kaggles#index'

  post 'kaggles' => 'kaggles#create'







end
