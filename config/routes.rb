Livra::Application.routes.draw do
  root :to => 'home#index'

  match 'profile/:number' => "home#profile", :as => :profile
  match 'question/:number/:response' => 'home#question', :as => :question
  match 'finish' => 'home#finish', :as => :finish
  match 'admin_results' => 'home#admin_results', :as => :admin_results
  match 'quota_full' => 'home#quota_full', :as => :quota_full
end
