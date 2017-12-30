Rails.application.routes.draw do

  # Name for the controllers  without affecting URI
  scope  module: :v1, constraints:ApiVersion.new('v1, true') do
    resources :todos do
      resources :items
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
