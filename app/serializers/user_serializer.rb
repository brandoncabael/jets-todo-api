class UserSerializer < ApplicationSerializer
  attributes :email, :name, :created_at, :updated_at
end