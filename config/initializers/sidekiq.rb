schedule_file = "config/schedule.yml"
if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.destroy_all!
  Sidekiq::RetrySet.new.clear
  Sidekiq::ScheduledSet.new.clear
  Sidekiq::Stats.new.reset

  Sidekiq::Cron::Job.load_from_hash(YAML.load_file(schedule_file))
  ScheduleWorker.perform_in(1.minute)
  ErrorJob.perform_now
end