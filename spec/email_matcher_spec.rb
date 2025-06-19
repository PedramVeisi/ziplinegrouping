require 'rspec'
require 'csv'
require_relative '../lib/record'
require_relative '../lib/matcher/email_matcher'

RSpec.describe EmailMatcher do
  def record_with_email(email, index)
    row = CSV::Row.new(["Email"], [email])
    Record.new(row, index)
  end

  it "groups rows with the same email" do
    records = [
      record_with_email("pedram@TeST.com", 0),
      record_with_email("pedram@test.com", 1),
      record_with_email("test@test.com", 2),
      record_with_email(nil, 3)
    ]

    matcher = EmailMatcher.new(records)
    groups = matcher.build_groups

    expect(groups[0]).to eq(groups[1])
    expect(groups[2]).not_to eq(groups[0])
    expect(groups[3]).not_to eq(groups[0])
  end

end