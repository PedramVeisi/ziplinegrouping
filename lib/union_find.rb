class UnionFind
  def initialize(size)
    @parents = Array.new(size) { |index| index } # Each element is its own group in the beginning
  end

  def find(x)
    @parents[x] = find(@parents[x]) if @parents[x] != x
    @parents[x]
  end

  def union(x, y)
    root_x = find(x)
    root_y = find(y)
    @parents[root_y] = root_x if root_x != root_y
  end

  def groups
    result = Hash.new { |hash, key| hash[key] = [] }
    @parents.each_index do |index|
      root = find(index)
      result[root] << index
    end

    result
  end

end
