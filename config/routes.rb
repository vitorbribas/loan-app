# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :proposals, only: :create
    end
  end
end
