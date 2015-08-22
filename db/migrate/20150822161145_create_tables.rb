class CreateTables < ActiveRecord::Migration
  def change
    create_table(:words) do |t|
      t.column :name, :string
    end
    create_table(:definitions) do |t|
      t.belongs_to :word, index: true
      t.column :definition, :string
      t.column :votes, :integer, null: 0 
    end
  end
end
