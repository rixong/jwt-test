class UserSerializer < ActiveModel::Serializer
  attributes :email, :name, :git_username, :git_userid
end