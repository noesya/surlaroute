module Orderable
  extend ActiveSupport::Concern

  included do
    scope :ordered, -> { order(:name) }
    scope :ordered_by_creation_date, -> { order(created_at: :desc) }
    scope :order_by, -> (order_param) {
      case order_param
      when "name:asc"
        order(name: :asc)
      when "name:desc"
        order(name: :desc)
      when "date:asc"
        order(created_at: :asc)
      when "date:desc"
        order(created_at: :desc)
      when "update_date:asc"
        order(updated_at: :asc)
      when "update_date:desc"
        order(updated_at: :desc)
      else
        all
      end
    }
  end

end
