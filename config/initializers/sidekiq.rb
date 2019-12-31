schedule_file = "config/schedule.yml"
if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash(YAML.load_file(schedule_file))
  ScheduleWorker.perform_in(1.minute)
end