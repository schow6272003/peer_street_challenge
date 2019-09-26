Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  concern :cbsa_base do
    get "find" =>  "cbsa#find" 
    get "find_all" => "cbsa#find_all"
 end 

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
       concerns :cbsa_base 
    end 
  end

  root 'pages#index'
  get '*path' => redirect('/')

end
