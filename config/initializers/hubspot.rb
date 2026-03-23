# frozen_string_literal: true

# Validate that HUBSPOT_ACCESS_TOKEN is set in production at boot time.
# In development/test, add it to your .env file:
#   HUBSPOT_ACCESS_TOKEN=your_private_app_token
if Rails.env.production? && ENV["HUBSPOT_ACCESS_TOKEN"].blank?
  raise "HUBSPOT_ACCESS_TOKEN environment variable is not set"
end
