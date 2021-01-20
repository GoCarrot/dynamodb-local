module Dynamodb
  module Local
    class Server

      DYNAMODB_LIB_DIR  = File.join(File.dirname(__FILE__), 'ext/DynamoDBLocal_lib')
      DYNAMODB_JAR_FILE = File.join(File.dirname(__FILE__), 'ext/DynamoDBLocal.jar')

      def self.start(args=ARGV)
        exec "java -Djava.library.path=#{DYNAMODB_LIB_DIR} -jar #{DYNAMODB_JAR_FILE} #{args.join(' ')}"
      end

      def self.start_background(args=ARGV)
        @pid = fork { exec "java -Djava.library.path=#{DYNAMODB_LIB_DIR} -jar #{DYNAMODB_JAR_FILE} #{args.join(' ')}" }
        Process.detach(@pid)
      end

      def self.stop_background
        Process.kill('SIGHUP', @pid)
      end
    end
  end
end
