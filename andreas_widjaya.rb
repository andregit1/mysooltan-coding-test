#!/usr/bin/env ruby

require 'optparse'
require 'json'

options = {}

# Define command line options
OptionParser.new do |opts|
  opts.banner = "Usage: mytools [options] logfile"

  opts.on("-t TYPE", "--type TYPE", [:text, :json], "Output type: text or json") do |t|
    options[:type] = t
  end

  opts.on("-o FILE", "--output FILE", "Output file path") do |o|
    options[:output] = o
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!

# Check if a logfile was provided
if ARGV.empty?
  puts "Error: no logfile provided"
  exit 1
end

logfile_path = ARGV.first

# Read the logfile
logfile_contents = File.read(logfile_path)

# Convert to plaintext or JSON
if options[:type] == :json
  logfile_contents = logfile_contents.lines.map { |line| { message: line.strip } }.to_json
end

# Output to file or STDOUT
if options[:output]
  File.write(options[:output], logfile_contents)
else
  puts logfile_contents
end


# # usage
# $ ./get_file_log.rb /var/log/syslog
# # outputs the contents of /var/log/syslog in plaintext

# $ ./get_file_log.rb /var/log/syslog -t json
# # outputs the contents of /var/log/syslog in JSON

# $ ./get_file_log.rb /var/log/syslog -o /tmp/syslog.txt
# # writes the contents of /var/log/syslog to /tmp/syslog.txt in plaintext

# $ ./get_file_log.rb /var/log/syslog -t json -o /tmp/syslog.json
# # writes the contents of /var/log/syslog to /tmp/syslog.json in JSON

# $ ./get_file_log.rb -h
# # prints the usage help text
# 
