module ApplicationHelper
  def masked_email(string)
    string.gsub(/(?<=.{2}).*@.*(?=\S{2})/, '****@****')
  end

  def masked_phone(string)
    string.gsub(/(?<=.{3}).+(?=.{2})/, '*******')
  end

  def masked_string(string)
    string = string.to_s # in case it was nil
    mask_length = [(string.length - 5), 0].max
    mask_length = 30 if mask_length > 30
    string.to_s.gsub(/.+(?=.{5})/, '•' * mask_length)
  end

  def default_images_formats_accepted
    Rails.application.config.default_images_formats.join(', ')
  end

  def default_images_formats_accepted_hint
    t('default_images_hint', formats: default_images_formats_accepted)
  end

  def tag_classes(classes = '')
    "btn btn-outline-dark btn-sm mb-2 rounded-pill #{classes}"
  end

  def tag_classes_disabled(classes = '')
    tag_classes("disabled #{classes}")
  end
end
