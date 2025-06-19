require 'rspec'
require 'csv'
require_relative '../lib/record'
require_relative '../lib/matcher/phone_matcher'

RSpec.describe PhoneMatcher do
  def record_with_phone(phone, index)
    row = CSV::Row.new(["Phone"], [phone])
    Record.new(row, index)
  end

  it "groups rows with the same phone" do
    records = [
      record_with_phone("(123) 456-7890", 0),
      record_with_phone("123.456.7890", 1),
      record_with_phone("987.654.3210", 2),
      record_with_phone(nil, 3)
    ]

    matcher = PhoneMatcher.new(records)
    groups = matcher.build_groups

    expect(groups[0]).to eq(groups[1])
    expect(groups[2]).not_to eq(groups[0])
    expect(groups[3]).not_to eq(groups[0])
  end

end