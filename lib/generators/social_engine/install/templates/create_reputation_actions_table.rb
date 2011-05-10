class CreateReputationActionsTable < ActiveRecord::Migration
  def self.up
    create_table :reputation_actions, :force => true do |t|
      t.string :name
      t.text :description
      t.integer :value
      t.timestamps
    end
  end

  def self.down
    drop_table :reputation_actions
  end
end