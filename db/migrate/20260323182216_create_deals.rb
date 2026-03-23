class CreateDeals < ActiveRecord::Migration[8.1]
  def change
    create_table :deals do |t|
      t.string :title
      t.integer :listing_num
      t.date :last_seen
      t.string :status
      t.string :hubspot_id
      t.string :summary

      t.timestamps
    end
  end
end
