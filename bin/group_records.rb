#!/usr/bin/env ruby

require 'optparse'
require_relative '../lib/csv_loader'
require_relative '../lib/matcher/phone_matcher'
require_relative '../lib/matcher/email_matcher'

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: group_records.rb --input FILE --matcher MATCHER"

  opts.on("-i", "--input FILE", "Path to input file") do |file|
    options[:input] = file
  end

  opts.on("-m", "--matcher MATCHER", "Matcher to use: phone, email, phone_or_email, email_or_phone") do |matcher|
    options[:matcher] = matcher
  end

end.parse!

unless options[:input] && options[:matcher]
  puts "Error: input file and matcher options are required"
  exit 1
end

matcher_class = case options[:matcher].downcase.strip
                when 'phone' then PhoneMatcher
                when 'email' then EmailMatcher
                else
                  abort "Unknown matcher: #{options[:matcher]}\nValid options: email, phone, email_or_phone, phone_or_email"
                end

records = CsvLoader.load_records(options[:input])
matcher = matcher_class.new(records)
groups = matcher.build_groups # a map showing the group for each record index

records.each { |record| puts record.inspect }
puts groups
