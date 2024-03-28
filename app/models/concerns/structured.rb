module Structured
  extend ActiveSupport::Concern

  included do
    has_many  :structure_values,
              class_name: "Structure::Value",
              as: :about,
              dependent: :destroy
    accepts_nested_attributes_for :structure_values

    has_many  :structure_options,
              through: :structure_values,
              source: :options,
              class_name: "Structure::Option"

    # Needed to execute before_validation callback on Structure::Value#files
    validates_associated :structure_values

    after_save :mark_options_used
  end

  class_methods do
    def structure_join_chain(alias_suffix)
      values_table_alias = self.connection.quote_column_name("structure_values#{alias_suffix}")
      options_values_table_alias = self.connection.quote_column_name("structure_options_values#{alias_suffix}")
      options_table_alias = self.connection.quote_column_name("structure_options#{alias_suffix}")
      "
      INNER JOIN \"structure_values\" #{values_table_alias}
          ON #{values_table_alias}.\"about_type\" = \'#{name}\'
          AND #{values_table_alias}.\"about_id\" = \"#{table_name}\".\"id\"
        INNER JOIN \"structure_options_values\" #{options_values_table_alias}
          ON #{options_values_table_alias}.\"value_id\" = #{values_table_alias}.\"id\"
        INNER JOIN \"structure_options\" #{options_table_alias}
          ON #{options_table_alias}.\"id\" = #{options_values_table_alias}.\"option_id\"
      "
    end
  end

  def items
    @items ||= Structure::Item.where(about_class: self.class.to_s).ordered
  end

  protected

  def mark_options_used
    structure_options.each do |option|
      option.denormalize_in_use!
    end
  end

  def searchable_text_from_structure_values
    CustomSanitizer.sanitize(raw_searchable_text_from_structure_values, 'string')
  end

  def raw_searchable_text_from_structure_values
    structure_values.pluck(:text).compact.join(' ')
  end
end
