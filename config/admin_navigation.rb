SimpleNavigation::Configuration.run do |navigation|
  navigation.renderer = ::Mazer::SimpleNavigationRenderer
  navigation.auto_highlight = true
  navigation.highlight_on_subpath = true
  navigation.selected_class = 'active'
  navigation.active_leaf_class = 'active'

  navigation.items do |primary|
    primary.item  :dashboard, t('admin.dashboard'), admin_root_path,  { icon: Icon::DASHBOARD, highlights_on: /admin$/ }
    # primary.item :experts, Expert.model_name.human(count: 2), admin_experts_path, { icon: Icon::EXPERT } if can?(:read, Expert) && Expert.accessible_by(current_ability).any?
    primary.item :users, User.model_name.human(count: 2), admin_users_path, { icon: Icon::USER } if can?(:read, User)
    primary.item :materials, Material.model_name.human(count: 2), admin_materials_path, { icon: Icon::MATERIAL } if can?(:read, Material)
    primary.item :structure, t('admin.structure'), nil, { icon: Icon::STRUCTURE } do |secondary|
      Structure::Item::ABOUT_CLASSES.each do |about_class|
        secondary.item about_class.to_s, about_class.to_s, admin_structure_items_path
      end
    end if can?(:edit, Structure::Item)
    # primary.item :analytics, 'Analytics', admin_analytics_path, { icon: Icon::ANALYTICS } if can?(:read, :analytics)
  end
end
