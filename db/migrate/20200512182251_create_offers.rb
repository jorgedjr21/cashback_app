class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.string :advertiser_name
      t.string :url
      t.text :description
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :enabled, default: false
      t.boolean :premium, default: false

      t.timestamps
    end
    add_index :offers, :advertiser_name, unique: true
  end
end
