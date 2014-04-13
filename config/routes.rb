Rails.application.routes.draw do
  resources :issues do
    collection do
      match 'confirm_merge', :via => [:get, :post]
      #get 'confirm_merge'
      post 'merge'
    end
  end
end
