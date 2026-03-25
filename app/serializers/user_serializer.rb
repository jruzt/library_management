class UserSerializer < BaseSerializer
  set_type :user

  attributes :first_name, :last_name, :full_name, :email, :role
end
