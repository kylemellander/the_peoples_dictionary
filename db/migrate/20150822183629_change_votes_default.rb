class ChangeVotesDefault < ActiveRecord::Migration
  def change
    change_column :definitions, :votes, :integer, :default => 0
  end
end
