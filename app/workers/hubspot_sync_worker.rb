# frozen_string_literal: true

class HubspotSyncWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default, retry: 3

  def perform
    Hubspot::SyncDealsService.new.call
  end
end
