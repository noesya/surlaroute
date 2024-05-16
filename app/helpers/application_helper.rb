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
    "tag btn btn-outline-dark btn-sm rounded-pill #{classes}"
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
    user_signed_in? && !current_user.visitor?
  end

  def page_path(page)
    "/#{page.path}"
  end

  def add_definitions(text)
    return '' unless text.present?
    all_mapping = definitions_mapping
    if all_mapping.any?
      regexp = Regexp.union(all_mapping.keys)
      text.gsub(regexp, all_mapping)
    else
      text
    end
  end

  private

  def definitions_mapping
    @definitions_mapping ||= begin
      # j'ai honte mais je n'ai pas envie de me prendre la tête ce soir : on a besoin de pouvoir gérer aussi la version downcase des termes
      definitions_mapping = Definition.all.pluck(:title, :text).map { |title, text| [title, definition_html(title, text)] }.to_h
      definitions_mapping_downcase = Definition.all.pluck(:title, :text).map { |title, text| [title.downcase, definition_html(title.downcase, text)] }.to_h
      aliases_mapping = Definition.all.joins(:aliases).pluck("definition_aliases.title", "definitions.text").map { |title, text| [title, definition_html(title, text)] }.to_h
      aliases_mapping_downcase = Definition.all.joins(:aliases).pluck("definition_aliases.title", "definitions.text").map { |title, text| [title.downcase, definition_html(title.downcase, text)] }.to_h
      all_mapping = definitions_mapping.merge(aliases_mapping).merge(definitions_mapping_downcase).merge(aliases_mapping_downcase).uniq.sort.reverse.to_h
    end
  end

  def definition_html(title, text)
    "<a href=\"#\" data-bs-toggle=\"tooltip\" title=\"#{text}\">#{title}</a>"
  end

end
