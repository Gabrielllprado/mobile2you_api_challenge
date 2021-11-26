class RenameTypeColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :list_titles, :type, :media_type
  end
end
