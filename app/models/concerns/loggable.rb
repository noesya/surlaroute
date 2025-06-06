module Loggable
  extend ActiveSupport::Concern

  included do
    has_many  :logs,
              class_name: 'User::Log',
              as: :about,
              dependent: :destroy
  end

end
