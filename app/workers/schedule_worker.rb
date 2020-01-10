class ScheduleWorker
  include Sidekiq::Worker

  def perform(*args)
    Sidekiq.schedule = {"schedule_job" => { class: "FutureMailJob",
                                        every: ["10s", first_in: "1m"],
                                        queue: "send_future" } }
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end
