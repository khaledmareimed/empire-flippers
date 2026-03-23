# frozen_string_literal: true

module EmpireFlippers
  class SyncListingsService
    STATUS_FOR_SALE = "for sale"

    def call
      listings = FetchListingsService.new.call
      listings.each { |listing| upsert_listing(listing) }
    end

    private

    def upsert_listing(listing)
      listing_num = listing["listing_number"]
      deal = Deal.find_by(listing_num: listing_num)

      if deal
        deal.update!(last_seen: Date.current)
      else
        Deal.create!(
          listing_num: listing_num,
          title:       listing["public_title"],
          summary:     listing["summary"],
          status:      STATUS_FOR_SALE,
          hubspot_id:  nil,
          last_seen:   Date.current
        )
      end
    end
  end
end
