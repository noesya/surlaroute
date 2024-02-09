module WithStructure
  extend ActiveSupport::Concern

  included do
    after_create :save_items_now_that_we_have_an_id
  end

  def items
    @items ||= Structure::Item.where(about_class: self.class.to_s)
                              .order(:position)
  end

  # {"19e17124-64af-4c55-aaec-c1edbb0fa8c9"=>"test", "0acedf80-25b6-44b3-ae6a-dcd8d1db4993"=>"test"}
  def items=(hash)
    # No id yet, needs to be resaved
    if new_record?
      @items_hash = hash
      return
    end 
    hash.each do |id, data|
      item = Structure::Item.find_by_id(id)
      next if item.nil?
      item.save_value(self, data)
    end
  end

  protected

  def save_items_now_that_we_have_an_id
    self.items = @items_hash
  end
end
