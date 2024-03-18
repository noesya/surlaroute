module Searchable
  extend ActiveSupport::Concern

  included do
    searchkick  language: "french",
                searchable: [:name, :description],
                word_start: [:name]
  end

end
