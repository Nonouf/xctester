require "xctester/version"
require "optparse"
require "POpen4"
require "FileUtils"
require "colorize"
require "timeout"
require "benchmark"

module Xctester
  class Tester
    def run
      $options = {:tests => 1, :verbose => false, :timeout => 300}
      $dir_name = "test_results"
      $file_prefix = "test_"
      $failed = 0

      OptionParser.new do |opts|
        opts.banner = "Usage: ./xctester [options]"

        opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          $options[:verbose] = v
        end
        opts.on("-t", "--tests test", "Specify how many time you want to run your unit tests") do |t|
          $options[:tests] = t.to_i
        end
        opts.on("-s", "--scheme scheme", "The scheme to execute") do |s|
          $options[:scheme] = s
        end
        opts.on("-p", "--project project", "The project file (xcodeproj) or workspace file (xcworkspace) to test") do |p|
          $options[:project] = p
        end
        opts.on("-o", "--timeout timeout", "The maximun time (in seconds) allowed to launch the test") do |o|
          $options[:timeout] = o
        end
      end.parse!

      def run_test(i)
        status = -1

        time = Benchmark.measure {
          proj = (File.extname($options[:project]) == ".xcworkspace")? "-workspace" : "-project"
          cmd = "xcodebuild #{proj} #{$options[:project]} -scheme '#{$options[:scheme]}' -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6,OS=9.2' test"
          output = ""

          status = POpen4::popen4(cmd) do |stdout, stderr, stdin, pid|
            puts " (#{pid})".green

            while out = stdout.gets || err = stderr.gets do
                if out
                  if $options[:verbose]
                    puts "#{out}"
                  end
                  output += out
                end

                if err
                  puts "#{err}".red
                  output += err
                end

            end
          end

          if status.exitstatus > 0
            path = "#{Dir.pwd}/#{$dir_name}"
            filename = "#{$file_prefix}#{i}.log"
            fullpath = "#{path}/#{filename}"

            puts "The logs can be found here -> #{fullpath}".yellow
            Dir.mkdir(path) unless File.exists?($dir_name)
            File.write(fullpath, output)
            $failed += 1
          end
        }
        puts "\nFinish running test #{i} with exit status #{status.exitstatus} (#{time.real}s)\n".green
      end

      i = 0

      if File.exists?($dir_name)
        puts "Delete logs' folders at #{$dir_name}"
        FileUtils.rm_rf($dir_name)
      end

      while i < $options[:tests] do
        print "Running test #{i + 1}...".green

        begin
          Timeout::timeout($options[:timeout]) do
            run_test(i + 1)
          end
        rescue Timeout::Error
          puts "Test #{i + 1} timed out and has been stopped.".yellow
        end
        i += 1
      end

      puts "#{$options[:tests] - $failed}/#{$options[:tests]} passed."
    end
  end
end
