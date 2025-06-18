require 'csv'
require_relative '../lib/record'

module CsvLoader
  def self.load_records(path)
    CSV.foreach(path, headers: true).with_index.map do |row, index|
      Record.new(row, index)
    end
  end
end