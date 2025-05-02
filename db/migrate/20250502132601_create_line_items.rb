class CreateLineItems < ActiveRecord::Migration[7.1]
  def change
    create_table :line_items do |t|
      t.string :sku
      t.integer :quantity
      t.boolean :original, default: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
