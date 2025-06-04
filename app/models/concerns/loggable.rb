module Loggable
  extend ActiveSupport::Concern

  included do
    has_many  :logs,
              as: :about,
              class_name: 'User::Log'
  end

end
