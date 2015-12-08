Rails.application.routes.draw do
  devise_for :users
    resources :posts do
    	member do
    		get "like", to: "posts#upvote"
    		get "dislike", to: "posts#downvote"
    	end
    	resources :comments do
    		member do
	    		get "like", to: "comments#upvote"
	    		get "dislike", to: "comments#downvote"
    		end #do end
    	end # :comments end    		
    end # :posts end

    root 'posts#index'
end
