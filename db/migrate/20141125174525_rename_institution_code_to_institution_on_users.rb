class RenameInstitutionCodeToInstitutionOnUsers < ActiveRecord::Migration
  def up
    rename_column :users, :institution_code, :institution
  end

  def down
    rename_column :users, :institution, :institution_code
  end
end
