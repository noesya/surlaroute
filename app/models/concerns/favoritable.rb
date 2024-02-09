module Favoritable
  extend ActiveSupport::Concern

  included do
    has_many  :favorites, 
              class_name: 'User::Favorite',
              foreign_key: :about
  end

end
