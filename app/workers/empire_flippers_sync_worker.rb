# frozen_string_literal: true

class EmpireFlippersSyncWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default, retry: 3

  def perform
    EmpireFlippers::SyncListingsService.new.call
    HubspotSyncWorker.perform_async
  end
end
