require 'rspec'
require 'csv'
require_relative '../lib/record'

RSpec.describe Record do

  let(:headers) { %w[FirstName LastName EmailAddress phone_number] }
  let(:values) { ["Bruce", "Wayne", "Bruce.Wayne@WayneEnterprise.COM", "(123) 456-7890"] }
  let(:csv_row) { CSV::Row.new(headers, values) }

  subject(:record) { Record.new(csv_row, 123) }

  describe '#initialize' do
    it 'stores row data and index' do
      expect(record.row).to eq(csv_row)
      expect(record.index).to eq(123)
    end
  end

  describe '#to_a' do
    it 'returns fields of a row as an array' do
      expect(record.to_a).to eq(values)
    end
  end

  describe '#headers' do
    it 'returns csv headers' do
      expect(record.headers).to eq(headers)
    end
  end

  describe '#normalize_emails' do
    it 'normalizes email from matching headers' do
      expect(record.normalize_emails).to eq(['bruce.wayne@wayneenterprise.com'])
    end

    it 'ignores non-email headers' do
      custom_headers = %w[Phone Zip]
      custom_row = CSV::Row.new(custom_headers, %w[1234567890 90210])
      expect(Record.new(custom_row, 1).normalize_emails).to eq([])
    end

    it 'handles multiple email fields' do
      headers = %w[Email1 Email2]
      values = %w[kent@dc.com wayne@dc.com]
      row = CSV::Row.new(headers, values)
      record = Record.new(row, 0)

      expect(record.normalize_emails).to match_array(%w[kent@dc.com wayne@dc.com])
    end

    it 'filters out blank emails' do
      row = CSV::Row.new(["email"], [" "])
      expect(Record.new(row, 0).normalize_emails).to eq([])
    end
  end

  describe '#normalize_phone_numbers' do
    it 'normalizes phone from matching headers' do
      expect(record.normalize_phone_numbers).to eq(['11234567890'])
    end

    it 'ignores non-phone headers' do
      row = CSV::Row.new(["Email"], ["wayne@dc.com"])
      expect(Record.new(row, 0).normalize_phone_numbers).to eq([])
    end

    it 'handles multiple phone fields' do
      headers = %w[Phone1 Phone2]
      values = ["(111) 111-1111", "222-222-2222"]
      row = CSV::Row.new(headers, values)
      record = Record.new(row, 2)

      expect(record.normalize_phone_numbers).to match_array(%w[11111111111 12222222222])
    end

    it 'filters out invalid or blank phones' do
      row = CSV::Row.new(["phone"], ["---"])
      expect(Record.new(row, 0).normalize_phone_numbers).to eq([])
    end
  end

end