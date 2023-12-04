module Filters
  class Admin::Materials < Filters::Base
    def initialize(user)
      super
      add_search
    end

  end
end
