class AddSearchableTextFromDataToPageBlocks < ActiveRecord::Migration[7.1]
  def change
    add_column :page_blocks, :searchable_text_from_data, :text
    Page::Block.reset_column_information
    Page::Block.all.find_each do |block|
      block.send(:denormalize_searchable_text_from_data)
    end
  end
end
