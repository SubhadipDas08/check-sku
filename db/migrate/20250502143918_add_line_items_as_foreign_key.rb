class AddLineItemsAsForeignKey < ActiveRecord::Migration[7.1]
  def change
    add_reference :line_items, :orders, foreign_key: false
    add_reference :orders, :line_items, foreign_key: true
  end
end
