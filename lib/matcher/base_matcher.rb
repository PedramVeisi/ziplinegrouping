class BaseMatcher

  def initialize(records)
    @records = records
  end

  def build_groups
    raise NotImplementedError
  end

  protected
  def build_index_to_group_map(uf)
    index_to_group_map = {}
    group_id = 0

    uf.groups.each_value do |members|
      members.each { |index| index_to_group_map[index] = group_id}
      group_id += 1
    end

    index_to_group_map
  end

end