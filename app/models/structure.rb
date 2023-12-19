module Structure
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  def self.table_name_prefix
    'structure_'
  end
end
