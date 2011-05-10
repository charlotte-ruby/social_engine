class AddReputationToUsersTable < ActiveRecord::Migration
  def self.up
    add_column :users, :reputation, :integer
  end

  def self.down
    remove_column :users, :reputation
  end
end