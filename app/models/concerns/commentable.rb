module Commentable
  extend ActiveSupport::Concern

  included do
    has_many  :comments, 
              class_name: 'User::Comment',
              foreign_key: :about
  end

end
