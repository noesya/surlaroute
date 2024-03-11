class SetNotNullInPages < ActiveRecord::Migration[7.1]
  def change
    change_column_null :pages, :name, false
    change_column_null :pages, :path, false
  end
end
