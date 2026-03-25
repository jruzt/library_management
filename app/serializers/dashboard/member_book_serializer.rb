class Dashboard
  class MemberBookSerializer < BaseSerializer
    set_type :book

    attributes :title, :author, :genre
  end
end
