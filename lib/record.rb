# lib/record.rb

require 'csv'
require_relative 'normalizer'

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

  def normalize_emails
    row.headers.select {|header| header.downcase.include?("email")}
       .map { |email_header| Normalizer.normalize_email(row[email_header]) }
       .reject { |email| email.empty? }
  end

  def normalize_phone_numbers
    row.headers.select {|header| header.downcase.include?("phone")}
       .map { |phone_header| Normalizer.normalize_phone(row[phone_header]) }
       .reject { |phone| phone.empty? }
  end

end
