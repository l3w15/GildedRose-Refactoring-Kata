describe MaturingItem do

  let(:aged_brie) { described_class.new("Aged Brie", 1, 0) }
  let(:max_quality_aged_brie) { described_class.new("Aged Brie", 0, 50) }

  describe '#update_item' do
    it 'ages the brie' do
      expect(aged_brie.update_item.sell_in).to eq 0
    end

    it 'increases brie quality the older it gets' do
      expect(aged_brie.update_item.quality).to eq 1
    end
  end
end
