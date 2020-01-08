class ErrorJob < ApplicationJob
  MyError = Class.new(ScriptError)
  queue_as :error_retry

  retry_on(LoadError, wait: 1.second, attempts: 6) do
    puts "Error"
  end

  def perform(*args)
    raise LoadError
  end
end
