Rails.application.routes.draw do
  RESOURCES_CONSTRAINT = lambda { |r| %w(recipe folder list).include?(r.params[:resource]) }

  concern :resource_users do |options|
    resources :users, api_only: true, except: [:show, :update], controller: 'resource_users'
  end

  namespace :api, constraints: {format: 'json'} do
    resources :users, api_only: true, except: :index do
      resources :favorites, only: [:index] do
        collection do
          get ':resource_type', to: 'favorites#index', constraints: RESOURCES_CONSTRAINT
          post ':resource_type', to: 'favorites#create', constraints: RESOURCES_CONSTRAINT
          delete ':resource_type/:id', to: 'favorites#destroy', constraints: RESOURCES_CONSTRAINT
        end
      end

      shallow do
        resources :lists, api_only: true
        resources :folders, api_only: true
        resources :recipes, api_only: true do
        end
      end
    end

    resources :recipes, only: [] do
      resources :fields, only: [:create, :update, :destroy], controller: 'recipe_fields'
      resources :ingredients, only: [:create, :update, :destroy], controller: 'recipe_ingredients'
    end

    resources :lists, only: [] do
      resources :ingredients, only: [:create, :update, :destroy], controller: 'list_ingredients'
      resources :recipes, only: [:create, :destroy], controller: 'list_recipes'
    end

    resources :folders, only: [] do
      resources :recipes, api_only: true, except: [:show, :update], controller: 'folder_recipes'
    end

    get ':resource_type/:resource_id/users', to: 'resource_users#index', constraints: RESOURCES_CONSTRAINT
    post ':resource_type/:resource_id/users', to: 'resource_users#create', constraints: RESOURCES_CONSTRAINT
    delete ':resource_type/:resource_id/users/:id', to: 'resource_users#destroy', constraints: RESOURCES_CONSTRAINT
  end
end
