class AddOriginalIdToRecords < ActiveRecord::Migration
  def self.up
    add_column :records, :original_id, :string
  end
end
