module ApplicationHelper

  def controller_class
    "#{controller_name.gsub('/', '--')}"
  end

  def body_classes(additional_body_class = '')
    classes = "controller-#{controller_class}"
    classes += " action-#{action_name}"
    classes += " #{controller_class}-#{action_name}"
    classes += " #{additional_body_class}" if additional_body_class.present?
    classes
  end

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
    "btn btn-outline-dark btn-sm rounded-pill #{classes}"
  end

  def tag_classes_disabled(classes = '')
    tag_classes("disabled #{classes}")
  end

  def polymorphic_option_path(option)
    # materials
    resources_class_name = option.item.about_class.to_s.downcase.pluralize
    # option_materials_path
    path_name = "option_#{resources_class_name}_path"
    # option_materials_path(item_slug: 'materiaux', option_slug: 'plastiques')
    public_send(path_name, item_slug: option.item.slug, option_slug: option.slug)
  end

  def user_is_subscribed?
    user_signed_in? && !user.visitor?
  end
end
