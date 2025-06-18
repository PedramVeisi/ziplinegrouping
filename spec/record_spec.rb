require 'rspec'
require 'csv'
require_relative '../lib/record'

RSpec.describe Record do

  let(:headers) { %w[First Last] }
  let(:values) { %w[Bruce Wayne] }
  let(:csv_row) { CSV::Row.new(headers, values) }

  subject(:record) { Record.new(csv_row, 0) }

  describe '#initialize' do
    it 'stores row data and index' do
      expect(record.row).to eq(csv_row)
      expect(record.index).to eq(0)
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

end