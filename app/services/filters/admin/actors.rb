module Filters
  class Admin::Actors < Filters::Base
    def initialize(user)
      super
      add_search
    end

  end
end
