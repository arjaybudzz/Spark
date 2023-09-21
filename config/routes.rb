Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :admins, only: %i[index show create update destroy]
      resources :subjects, only: %i[index show create update destroy]
      resources :topics, only: %i[index show create update destroy]
      resources :quizzes, only: %i[index show create update destroy]
      resources :quiz_items, only: %i[index show create update destroy]

      resources :tokens, only: %i[create]
      resources :subject_tokens, only: %i[create]
      resources :topic_tokens, only: %i[create]
      resources :quiz_tokens, only: %i[create]
      resources :quiz_item_tokens, only: %i[create]
    end
  end
end
