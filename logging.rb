require 'pathname'

module Logging

	class LogDirectoryError < RuntimeError
	end

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

		def check_dir(dir)
			raise LogDirectoryError,
				"logging directory #{dir} does not exist" unless Dir.exist?(dir)
			raise LogDirectoryError,
				"cannot write to logging dir #{dir}" unless can_write_to_dir?(dir)
		end

		private

		def can_write_to_dir?(dir_name)
			return false unless Dir.exist?(dir_name)
			test_file_path = Pathname.new(dir_name) + Time.new.strftime("%Y%m%d%H%m%S.test")
			begin
				test_file_path.open("w") {}
				true
			rescue Errno::EACCES
				false
			ensure
				test_file_path.delete if test_file_path.exist?
			end
		end
	end

	def logger
		Logging.logger
	end
end
