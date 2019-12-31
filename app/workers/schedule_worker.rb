class ScheduleWorker
  include Sidekiq::Worker

  def perform(*args)
    Sidekiq.schedule = YAML.load_file("config/future_schedule.yml")
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end
