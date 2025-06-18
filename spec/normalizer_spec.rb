require 'rspec'
require_relative '../lib/normalizer'

RSpec.describe Normalizer do
  describe '.normalize_email' do
    it 'normalizes a standard email' do
      expect(Normalizer.normalize_email('  Bruce.Wayne@wayneenterprise.COM ')).to eq('bruce.wayne@wayneenterprise.com')
    end

    it 'returns empty string for nil input' do
      expect(Normalizer.normalize_email(nil)).to eq('')
    end

    it 'returns empty string for empty string' do
      expect(Normalizer.normalize_email('   ')).to eq('')
    end

    it 'does not modify already-normalized emails' do
      expect(Normalizer.normalize_email('pedram@test.com')).to eq('pedram@test.com')
    end
  end

  describe '.normalize_phone' do
    it 'removes non-digit characters' do
      expect(Normalizer.normalize_phone('(123) 456-7890')).to eq('11234567890')
    end

    it 'handles dots and spaces' do
      expect(Normalizer.normalize_phone('123.456.7890')).to eq('11234567890')
      expect(Normalizer.normalize_phone('123 456 7890')).to eq('11234567890')
    end

    it 'handles already-clean numbers' do
      expect(Normalizer.normalize_phone('1234567890')).to eq('11234567890')
    end

    it 'returns empty string for nil or blank' do
      expect(Normalizer.normalize_phone(nil)).to eq('')
      expect(Normalizer.normalize_phone('   ')).to eq('')
    end

    it 'returns empty string if no digits found' do
      expect(Normalizer.normalize_phone('---')).to eq('')
    end
  end
end