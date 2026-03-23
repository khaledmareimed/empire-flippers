# frozen_string_literal: true

module EmpireFlippers
  class FetchListingsService
    include HTTParty

    BASE_URL = "https://api.empireflippers.com/api/v1/listings/list"
    LISTING_STATUS = "For Sale"
    PAGE_LIMIT = 100
    RATE_LIMIT_SLEEP = 1

    def call
      all_listings = []
      current_page = 1

      loop do
        response = fetch_page(current_page)
        data = parse_response!(response)

        all_listings.concat(data["listings"])

        total_pages = data["pages"].to_i
        break if current_page >= total_pages

        current_page += 1
        sleep(RATE_LIMIT_SLEEP)
      end

      all_listings
    end

    private

    def fetch_page(page)
      self.class.get(BASE_URL, query: {
        limit: PAGE_LIMIT,
        listing_status: LISTING_STATUS,
        page: page
      })
    end

    def parse_response!(response)
      unless response.success?
        raise "Empire Flippers API error: HTTP #{response.code} — #{response.message}"
      end

      body = response.parsed_response
      data = body["data"]

      raise "Empire Flippers API returned unexpected response format" unless data.is_a?(Hash)

      data
    end
  end
end
