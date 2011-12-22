Livra::Application.routes.draw do
  root :to => 'home#index'

  match 'question/:number/:response' => 'home#question', :as => :question
  match 'finish' => 'home#finish', :as => :finish
end
