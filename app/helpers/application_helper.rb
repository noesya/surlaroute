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

  def submit(form)
    form.button :submit,
                t('save'),
                class: button_classes,
                form: form.options.dig(:html, :id)
  end

  def button_classes(additional = '', **options)
    classes = "btn btn-primary btn-xs #{additional}"
    classes += ' disabled' if options[:disabled]
    classes
  end

  def button_classes_danger(**options)
    classes = 'btn btn-danger btn-xs'
    classes += ' disabled' if options[:disabled]
    classes
  end
end
