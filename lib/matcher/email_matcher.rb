require_relative '../union_find'
require_relative 'base_matcher'

class EmailMatcher < BaseMatcher
  def build_groups
    uf = UnionFind.new(@records.size)
    email_to_indicies = Hash.new { |hash, key| hash[key] = [] }

    @records.each_with_index do |record, index|
      record.normalize_emails.each do |email|
        email_to_indicies[email] << index
      end
    end

    email_to_indicies.each_value do |indices|
      first = indices.first
      indices.each { |index| uf.union(first, index) }
    end

    build_index_to_group_map(uf)

  end
end
