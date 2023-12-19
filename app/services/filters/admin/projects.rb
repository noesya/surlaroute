module Filters
  class Admin::Projects < Filters::Base
    def initialize(user)
      super
      add_search
    end

  end
end
