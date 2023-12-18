module WithCriterions
  extend ActiveSupport::Concern

  def criterions
    Criterion.where(about_class: self.class.to_s).order(:position)
  end

  # {"19e17124-64af-4c55-aaec-c1edbb0fa8c9"=>"test", "0acedf80-25b6-44b3-ae6a-dcd8d1db4993"=>"test"}
  def criterions=(hash)
    hash.each do |criterion_id, criterion_data|
      criterion = Criterion.find(criterion_id)
      value = value_for(criterion)
      value.text = criterion_data
      value.save
    end
  end

  def value_for(criterion)
    criterion.values.where(about: self).first_or_create
  end
end
