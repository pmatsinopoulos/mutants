# config/unicorn.rb
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 1)
timeout 60
timeout 300 if ENV['RACK_ENV'] == 'staging'
timeout 300 if %w(development none).include? ENV['RACK_ENV']
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end
