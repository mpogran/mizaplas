Rails.application.routes.draw do
  concern :resource_users do |options|
    resources :users, api_only: true, except: [:show, :update], controller: 'resource_users'
  end

  namespace :api, constraints: {format: 'json'} do
    resources :users, api_only: true, except: [:destroy, :update] do
      patch 'me', on: :collection, action: :update, as: :update_me
      delete 'me', on: :collection, action: :destroy, as: :destroy_me
    end
    resources :favorites, api_only: true, except: [:show, :update]

    resources :recipes, api_only: true, concerns: :resource_users do
      resources :fields, api_only: true, except: :show, controller: 'recipe_fields'
      resources :ingredients, api_only: true, except: :show, controller: 'recipe_ingredients'
    end

    resources :lists, api_only: true, concerns: :resource_users do
      resources :ingredients, api_only: true, except: :show, controller: 'list_ingredients'
      resources :recipes, api_only: true, except: :show, controller: 'list_recipes'
    end

    resources :folders, api_only: true, concerns: :resource_users do
      resources :recipes, api_only: true, except: :show, controller: 'folder_recipes'
    end
  end
end
