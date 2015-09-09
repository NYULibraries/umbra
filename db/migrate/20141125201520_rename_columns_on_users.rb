class RenameColumnsOnUsers < ActiveRecord::Migration
  def up
    rename_column :users, :status, :patron_status
  end

  def down
    rename_column :users, :patron_status, :status
  end
end
