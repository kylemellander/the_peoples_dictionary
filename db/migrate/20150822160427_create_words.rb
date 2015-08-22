class CreateWords < ActiveRecord::Migration
  def change
    create_table(:words) do |w|
      w.column(:word, :string)
    end
  end
end
