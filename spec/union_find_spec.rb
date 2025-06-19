require 'rspec'
require_relative '../lib/union_find'

RSpec.describe UnionFind do
  it "each element is in its own group in the beginning" do
    uf = UnionFind.new(3)
    expect(uf.groups.values.sort).to contain_exactly([0], [1], [2])
  end

  it "merges two elements into the same group" do
    uf = UnionFind.new(3)
    uf.union(0, 1)

    groups = uf.groups.values.sort
    expect(groups).to include([0, 1])
  end

  it "correctly creates transactive grouping" do
    uf = UnionFind.new(4)
    uf.union(0, 1)
    uf.union(1, 2)

    root = uf.find(0)
    expect([uf.find(1), uf.find(2)]).to all(eq(root))
    expect(uf.groups[root]).to eq([0, 1, 2])

  end

end