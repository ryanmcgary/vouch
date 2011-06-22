Vouch::Application.routes.draw do 

  match '/auth/:provider/callback' => 'authentications#create'
  match 'authentications/closewindow' => 'authentications#closewindow' 
  match 'authentications/force' => 'authentications#force'
  match "/recordings/editrecording.:format" => "recordings#editrecording"
  match "/recordings/trunk.:format"         => "recordings#trunk"
  match "/recordings/makecall.:format"      => "recordings#makecall"
  match "/recordings/record.:format"        => "recordings#record"
  match "/recordings/hangup.:format"        => "recordings#hangup" 
  match "/recordings/makecall(.:format)"    => "recordings#makecall"
 
  devise_for :users, :controllers => { :registrations => 'registrations' }
       
  resources :authentications                                  

  resources :sites do
    resources :remoteurls do
      resources :reviews, :only => [:index, :create, :new, :destroy]   
      resources :recordings
    end
    resource :lanyard do
      member do
        get :full_lanyard
        get :embed
        get :slider_embed
      end
    end
  end

  
  #  match '/sites/:url' => 'sites#show'
 
  # The priority is based upon order of creation:
  # first created -> highest priority.
  root :to => 'sites#index'
  # Sample of regular route:
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
