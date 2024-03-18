class AddInAncestorTreeToPages < ActiveRecord::Migration[7.1]
  def change
    add_column :pages, :in_lab_tree, :boolean, default: false
    add_column :pages, :in_toolbox_tree, :boolean, default: false

    Page.reset_column_information
    Page.all.find_each do |page|
      page.update_column :in_lab_tree, page.ancestors_and_self.detect { |ancestor| ancestor == Page.lab }
      page.update_column :in_toolbox_tree, page.ancestors_and_self.detect { |ancestor| ancestor == Page.toolbox }
    end
  end
end
