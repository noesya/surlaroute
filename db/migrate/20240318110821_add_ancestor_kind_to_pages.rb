class AddAncestorKindToPages < ActiveRecord::Migration[7.1]
  def change
    add_column :pages, :ancestor_kind, :integer, default: 0
    Page.reset_column_information
    Page.all.find_each do |page|
      if page.ancestors_and_self.detect { |ancestor| ancestor == Page.lab }
        page.update_column :ancestor_kind, :lab
      elsif page.ancestors_and_self.detect { |ancestor| ancestor == Page.toolbox }
        page.update_column :ancestor_kind, :toolbox
      else
        page.update_column :ancestor_kind, :neutral
      end
    end
  end
end
