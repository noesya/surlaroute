module Favoritable
  extend ActiveSupport::Concern

  included do
    has_many  :user_favorites,
              class_name: 'User::Favorite',
              as: :about,
              dependent: :destroy
  end

end
