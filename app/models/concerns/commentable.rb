module Commentable
  extend ActiveSupport::Concern

  included do
    has_many  :comments,
              class_name: 'User::Comment',
              as: :about,
              dependent: :destroy
  end

end
