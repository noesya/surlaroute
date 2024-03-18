module Searchable
  extend ActiveSupport::Concern

  included do
    searchkick  language: "french",
                word_start: [:name]
  end

end
