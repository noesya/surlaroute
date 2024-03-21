module Searchable
  extend ActiveSupport::Concern

  included do
    searchkick  language: "french",
                word_start: [:name]
  end

  protected

  def search_data
    raise NoMethodError.new("search_data must be defined in the model.")
  end

end
