require 'rspec'
require 'csv'
require_relative '../lib/record'
require_relative '../lib/matcher/email_or_phone_matcher'

RSpec.describe EmailOrPhoneMatcher do
  def record_with_email_or_phone(email, phone, index)
    row = CSV::Row.new(%w[Email Phone], [email, phone])
    Record.new(row, index)
  end

  it "groups rows with shared email or phone" do
    records = [
      record_with_email_or_phone("pedram@test.ca", nil, 0),
      record_with_email_or_phone("pedram@TEST.CA", nil, 1),
      record_with_email_or_phone(nil, '123-456-7890', 2),
      record_with_email_or_phone(nil, '(123) 456-7890', 3),
      record_with_email_or_phone('test@test.ca', '999-999-9999', 4)
    ]

    matcher = EmailOrPhoneMatcher.new(records)
    groups = matcher.build_groups

    expect(groups[0]).to eq(groups[1]) # email match
    expect(groups[2]).to eq(groups[3]) # phone match
    expect(groups[4]).not_to eq(groups[0])
    expect(groups[4]).not_to eq(groups[2])
  end

end