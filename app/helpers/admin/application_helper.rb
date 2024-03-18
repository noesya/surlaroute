module Admin::ApplicationHelper

  def button_classes(additional = '', **options)
    classes = "btn btn-dark btn-sm #{additional}"
    classes += ' disabled' if options[:disabled]
    classes
  end

  def button_classes_danger(**options)
    classes = 'btn btn-outline-danger btn-sm'
    classes += ' disabled' if options[:disabled]
    classes
  end

  def button_classes_minor(**options)
    classes = 'btn btn-outline-dark btn-sm'
    classes += ' disabled' if options[:disabled]
    classes
  end

  def table_classes(with_actions: true)
    classes = 'table'
    classes += ' table--with-actions' if with_actions
    classes
  end

  def table_actions_cell
    'text-end pe-0'
  end

  def show(object, property, type: nil, value: nil)
    value ||= object.public_send property
    label = object.class.human_attribute_name property
    begin
      type ||= object.class.columns_hash[property.to_s].type
    rescue
    end
    if object.respond_to?("#{property}_i18n")
      type = 'enum'
      value = object.send("#{property}_i18n")
    end
    # return if value.blank?
    html = '<div class="mb-5">'
    # html += type.to_s
    html += "<label class=\"small text-muted\">#{ label }</label>"
    html += render "admin/application/show/#{type}", value: value unless type.nil?
    html += '</div>'
    html.html_safe
  end

  def show_link_inline(object, **options)
    link_to_if  can?(:read, object),
                object.to_s.truncate(50),
                polymorphic_url_param(object, **options)
  end

  def show_link(object, html_classes: button_classes, **options)
    link_to_if  can?(:read, object),
                options.delete(:label) || t('show'),
                polymorphic_url_param(object, **options),
                class: html_classes
  end

  def edit_link(object, html_classes: button_classes, **options)
    return unless can?(:update, object)
    link_to options.delete(:label) || t('edit'),
            polymorphic_url_param(object, prefix: :edit, **options),
            class: html_classes
  end

  def destroy_link(object, html_classes: button_classes_danger, **options)
    return unless can?(:destroy, object)
    link_to options.delete(:label) || t('delete'),
            polymorphic_url_param(object, **options),
            method: :delete,
            data: { confirm: options.delete(:confirm_message) || t('please_confirm') },
            class: html_classes
  end

  def create_link(object_class, html_classes: button_classes, **options)
    return unless can?(:create, object_class)
    object_class_sym = object_class.name.underscore.gsub('/', '_').to_sym

    link_to options.delete(:label) || t('create'),
            polymorphic_url_param(object_class_sym, prefix: :new, **options),
            class: html_classes
  end

  def submit(form)
    form.button :submit,
                t('save'),
                class: button_classes,
                form: form.options.dig(:html, :id)
  end

  def collection_tree(list, except = nil)
    collection = []
    list.root.ordered.each do |object|
      collection.concat(object.self_and_children(0))
    end
    collection = collection.reject { |o| o[:id] == except.id } unless except.nil?
    collection
  end

  def default_images_formats_accepted
    Rails.application.config.default_images_formats.join(', ')
  end

  def images_formats_accepted_hint(formats: default_images_formats_accepted)
    t('admin.file_hint_with_formats_and_filesize', filesize: number_to_human_size(Rails.application.config.default_image_max_size), formats: formats)
  end

  def file_formats_accepted_hint(formats: '')
    return if formats.blank?
    t('admin.file_hint_with_formats', formats: formats)
  end

  private

  def polymorphic_url_param(object_or_class, **options)
    prefix = options.fetch(:prefix, nil)
    namespace = options.fetch(:namespace, :admin)
    url_options = options.fetch(:url_options, {})

    [prefix, namespace, object_or_class, url_options].compact
  end
end
