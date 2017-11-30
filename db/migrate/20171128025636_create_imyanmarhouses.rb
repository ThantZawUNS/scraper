class CreateImyanmarhouses < ActiveRecord::Migration
  def change
    create_table :imyanmarhouses do |t|
      t.string :transaction_type
      t.string :property_type
      t.string :finish_state
      t.string :region
      t.string :township
      t.string :price
      t.string :furnished_or_not
      t.string :bed_room
      t.string :bath_room
      t.string :phone
      t.text :description
      t.string :property_created_time
      t.string :property_id
      t.timestamps null: false
    end
  end
end





