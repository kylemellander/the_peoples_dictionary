class CreateDefinitions < ActiveRecord::Migration
  def change
    create_table(:definitions) do |d|
      d.column(:definition, :string)
      d.column(:votes, :integer)
      d.column(:word_id, :integer)
    end
  end
end
