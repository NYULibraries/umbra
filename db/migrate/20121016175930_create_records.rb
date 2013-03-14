class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :collection
      t.string :title
      t.text :identifier
      t.text :description
      t.text :record_attributes

      t.timestamps
    end
  end
end
