# frozen_string_literal: true

class DealsController < ApplicationController
  def index
    @deals = Deal.order(last_seen: :desc, listing_num: :asc)
  end
end
