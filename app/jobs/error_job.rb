class ErrorJob < ApplicationJob
  MyError = Class.new(StandardError)
  queue_as :error_retry

  retry_on(StandardError, wait: 1.hour, attempts: 6) do
    puts "Error"
  end

  def perform(*args)
    begin
      require 'fake_path'
    rescue ScriptError => e
      raise MyError
    end
  end
end
