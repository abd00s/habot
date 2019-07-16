class DummyWorker
  include Sidekiq::Worker

  def perform
    Goals::DummyService.run
  end
end
