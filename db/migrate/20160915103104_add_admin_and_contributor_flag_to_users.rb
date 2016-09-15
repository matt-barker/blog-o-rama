class AddAdminAndContributorFlagToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :users, :contributor, :boolean, default: false, null: false
  end
end
