require 'redis'
class RedisConnector
  def self.set(key, value)
    begin
      if Redis.new(url: ENV['REDIS_URL']).set(key, value) != "OK"
        STDERR.puts("error setting #{key} with #{value}")
      end
    rescue StandardError => e
      STDERR.puts("setting #{key} with #{value} raised #{e}")
    end
  end

  def self.get(key)
    begin
      Redis.new(url: ENV['REDIS_URL']).get(key)
    rescue StandardError => e
      STDERR.puts("setting #{key} with #{value} raised #{e}")
    end
  end
end
