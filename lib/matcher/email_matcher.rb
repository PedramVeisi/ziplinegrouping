require_relative '../union_find'
require_relative 'base_matcher'

class EmailMatcher < BaseMatcher
  def build_groups
    uf = UnionFind.new(@records.size)
    email_to_indexes = Hash.new { |hash, key| hash[key] = [] }

    @records.each_with_index do |record, index|
      record.normalize_emails.each do |email|
        email_to_indexes[email] << index
      end
    end

    email_to_indexes.each_value do |indexes|
      first = indexes.first
      indexes.each { |index| uf.union(first, index) }
    end

    build_index_to_group_map(uf)

  end
end
