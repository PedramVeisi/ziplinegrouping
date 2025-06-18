  require 'rspec'
require 'csv'
require_relative '../lib/csv_loader'

RSpec.describe CsvLoader do
  describe ".load_records" do
    let(:temp_path) { File.expand_path('../sample.csv', __FILE__) }

    before do
      File.write(temp_path, "First,Last\nBruce,Wayne\nClark,Kent")
    end

    after do
      File.delete(temp_path)
    end

    it 'loads all records with indexes' do
      records = CsvLoader.load_records(temp_path)

      expect(records.size).to eq(2)
      expect(records[0].to_a).to eq(%w[Bruce Wayne])
      expect(records[1].to_a).to eq(%w[Clark Kent])
      expect(records[0].index).to eq(0)
    end

  end
end