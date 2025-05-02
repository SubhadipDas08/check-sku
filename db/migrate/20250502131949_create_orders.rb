class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :external_id
      t.string :locked_at
      t.string :datetime
      t.index :external_id, unique: true


      t.timestamps
    end
  end
end
