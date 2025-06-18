#!/usr/bin/env ruby

require_relative '../lib/csv_loader'

if ARGV.empty?
  puts "Usage ./bin/group_records.rb FILE"
  exit 1
end

file_path = ARGV[0]
records = CsvLoader.load_records(file_path)

records.each do |record|
  puts "Row #{record.index}: #{record.to_a}"
end