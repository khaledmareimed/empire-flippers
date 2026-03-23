# frozen_string_literal: true

module Hubspot
  class SyncDealsService
    CLOSE_DATE_DAYS_FROM_NOW = 30

    def call
      client = build_client
      api = client.crm.deals.basic_api

      Deal.where(hubspot_id: nil).find_each do |deal|
        create_hubspot_deal(api, deal)
      end
    end

    private

    def build_client
      ::Hubspot::Client.new(access_token: ENV.fetch("HUBSPOT_ACCESS_TOKEN"))
    end

    def create_hubspot_deal(api, deal)
      Deal.transaction do
        current = Deal.lock.find(deal.id)
        return if current.hubspot_id.present?

        response = api.create(body: {
          "properties"   => {
            "dealname"  => "listing #{current.listing_num}",
            "closedate" => close_date_ms
          },
          "associations" => []
        })
        current.update!(hubspot_id: response.id)
      end
    rescue StandardError => e
      Rails.logger.error(
        "HubSpot API error for deal listing_num=#{deal.listing_num}: #{e.message}"
      )
    end

    def close_date_ms
      ((Date.current + CLOSE_DATE_DAYS_FROM_NOW).to_time.utc.to_i * 1000).to_s
    end
  end
end
