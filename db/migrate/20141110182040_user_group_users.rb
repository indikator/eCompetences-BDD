class UserGroupUsers < ActiveRecord::Migration
  def change
    create_join_table :user_groups, :users do |t|
      t.index :user_id
      t.index :user_group_id
    end
  end
end
