Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :admins, only: %i[index show create update destroy]
      resources :subjects, only: %i[index show create update destroy]
      resources :topics, only: %i[index show create update destroy]
      resources :quizzes, only: %i[index show create update destroy]
      resources :quiz_items, only: %i[index show create update destroy]
      resources :users, only: %i[index show create update destroy]
      resources :answer_sheets, only: %i[index show]
      resources :quiz_answers, only: %i[index show update]
      resources :posts, only: %i[index show create update destroy]
      resources :comments, only: %i[index show create update destroy]
      resources :replies, only: %i[index show create]
      resources :subject_coverages, only: %i[index show create]

      resources :tokens, only: %i[create]
      resources :subject_tokens, only: %i[create]
      resources :topic_tokens, only: %i[create]
      resources :quiz_tokens, only: %i[create]
      resources :quiz_item_tokens, only: %i[create]
      resources :user_tokens, only: %i[create]
      resources :answer_sheet_tokens, only: %i[create]
      resources :post_tokens, only: %i[create]
      resources :comment_tokens, only: %i[create]
      resources :subject_coverage_tokens, only: %i[create]
    end
  end
end
