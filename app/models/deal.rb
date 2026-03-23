# frozen_string_literal: true

class Deal < ApplicationRecord
  validates :listing_num, presence: true, uniqueness: true
  validates :status, presence: true

  scope :by_listing_num, ->(num) { find_by(listing_num: num) }
end
