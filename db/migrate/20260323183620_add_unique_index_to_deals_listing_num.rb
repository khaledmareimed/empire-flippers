# frozen_string_literal: true

class AddUniqueIndexToDealsListingNum < ActiveRecord::Migration[8.1]
  def change
    add_index :deals, :listing_num, unique: true
  end
end
