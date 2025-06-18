# lib/record.rb

require 'csv'

# Represents a single record from CSV data
#
# Usage:
# record = Record.new(csv_row)
class Record
  attr_reader :row, :index

  def initialize(row, index)
    @row = row
    @index = index
  end

  def headers
    row.headers
  end

  def to_a
    row.fields
  end

end
