class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :password, :auth_token
end
