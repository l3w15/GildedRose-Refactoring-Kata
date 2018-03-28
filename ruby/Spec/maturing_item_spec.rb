require_relative '../base_item'

describe MaturingItem do

  let(:aged_brie) { described_class.new("Aged Brie", 1, 0) }
  let(:max_quality_aged_brie) { described_class.new("Aged Brie", 0, 50) }

  describe '#update_item' do
    it 'ages the brie and increases the quality' do
      expect(aged_brie.update_item).to have_attributes(:sell_in => 0, :quality => 1)
    end

    it 'cannot have quality over max quality' do
      expect(max_quality_aged_brie.update_item.quality).to eq MAX_QUALITY
    end
  end
end
