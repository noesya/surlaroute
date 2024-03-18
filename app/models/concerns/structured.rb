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
    raw_texts_from_structure_values = structure_values.pluck(:text).compact
    CustomSanitizer.sanitize(raw_texts_from_structure_values.join(' '), 'string')
  end
end
