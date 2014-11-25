class AddLoginFieldsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :provider, :string, null: false, default: ""
    add_column :users, :aleph_id, :string
    add_column :users, :institution_code, :string
    add_column :users, :status, :string
    add_column :users, :admin, :boolean
    add_column :users, :admin_collections, :text
  end

  def down
    remove_column :users, :provider
    remove_column :users, :aleph_id
    remove_column :users, :institution_code
    remove_column :users, :status
    remove_column :users, :admin
    remove_column :users, :admin_collections
  end
end
