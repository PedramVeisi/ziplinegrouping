#!/usr/bin/env ruby

require 'optparse'
require_relative '../lib/csv_loader'
require_relative '../lib/matcher/phone_matcher'
require_relative '../lib/matcher/email_matcher'
require_relative '../lib/matcher/email_or_phone_matcher'

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: group_records.rb --input FILE --matcher MATCHER"

  opts.on("-i", "--input FILE", "Path to input file") do |file|
    options[:input] = file
  end

  opts.on("-m", "--matcher MATCHER", "Matcher to use: phone, email, phone_or_email, email_or_phone") do |matcher|
    options[:matcher] = matcher
  end

  opts.on("-o", "--output FILE", "Path to output file") do |file|
    options[:output] = file
  end

end.parse!

unless options[:input] && options[:matcher]
  puts "Error: input file and matcher options are required"
  exit 1
end

unless File.exist?(options[:input])
  abort("File not found: #{options[:input]}")
end

matcher_class = case options[:matcher].downcase.strip
                when 'phone' then PhoneMatcher
                when 'email' then EmailMatcher
                when /(email_or_phone|phone_or_email)/ then EmailOrPhoneMatcher
                else
                  abort "Unknown matcher: #{options[:matcher]}\nValid options: email, phone, email_or_phone, phone_or_email"
                end

records = CsvLoader.load_records(options[:input])
matcher = matcher_class.new(records)
groups = matcher.build_groups # a map showing the group for each record index

input_file_name = File.basename(options[:input], ".csv")
output_file_name = options[:output] || "grouped_#{input_file_name}.csv"

CSV.open(output_file_name, "w") do |csv|
  csv << ["Group ID"] + records.first.headers
  records.each_with_index
         .sort_by { |_, index| groups[index] }
         .each do |record, index|
    csv << [groups[index], record.to_a]
  end
end

puts "Wrote grouped results to #{output_file_name}"