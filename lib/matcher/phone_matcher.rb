require_relative '../union_find'
require_relative 'base_matcher'

class PhoneMatcher < BaseMatcher
  def build_groups
    uf = UnionFind.new(@records.size)
    phone_to_indexes = Hash.new { |hash, key| hash[key] = [] }

    @records.each_with_index do |record, index|
      record.normalize_phone_numbers.each do |phone|
        phone_to_indexes[phone] << index
      end
    end

    phone_to_indexes.each_value do |indexes|
      first = indexes.first
      indexes.each { |index| uf.union(first, index) }
    end

    build_index_to_group_map(uf)

  end
end
