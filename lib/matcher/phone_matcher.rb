require_relative '../union_find'
require_relative 'base_matcher'

class PhoneMatcher < BaseMatcher
  def build_groups
    uf = UnionFind.new(@records.size)
    phone_to_indicies = Hash.new { |hash, key| hash[key] = [] }

    @records.each_with_index do |record, index|
      record.normalize_phone_numbers.each do |phone|
        phone_to_indicies[phone] << index
      end
    end

    phone_to_indicies.each_value do |indices|
      first = indices.first
      indices.each { |index| uf.union(first, index) }
    end

    build_index_to_group_map(uf)

  end
end
