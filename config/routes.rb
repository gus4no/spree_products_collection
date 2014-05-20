Spree::Core::Engine.add_routes do

  namespace :admin do
    resources :collections
  end

  namespace :api, :defaults => { :format => 'json' } do
    resources :collections
  end
end
