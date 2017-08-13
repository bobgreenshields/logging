module Logging
	class NullLogger
		def unknown(*); end
		def debug(*); end
		def info(*); end
		def warn(*); end
		def error(*); end
		def fatal(*); end
	end

	class << self
		def logger=(new_logger)
			@logger = new_logger
		end

		def logger
			@logger ||= NullLogger.new
		end
	end

	def logger
		Logging.logger
	end
end
