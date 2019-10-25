Jets.application.routes.draw do
  post 'api/v1/authentication/register', to: "authentication#register"
  post 'api/v1/authentication/login', to: "authentication#login"
  resources :users, prefix: "api/v1", only: %w[update delete]
  root "jets/public#show"

  # The jets/public#show controller can serve static utf8 content out of the public folder.
  # Note, as part of the deploy process Jets uploads files in the public folder to s3
  # and serves them out of s3 directly. S3 is well suited to serve static assets.
  # More info here: https://rubyonjets.com/docs/extras/assets-serving/
  any "*catchall", to: "jets/public#show"
end
