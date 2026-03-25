class BorrowingUserSerializer < BaseSerializer
  set_type :user

  attributes :full_name, :email
end
