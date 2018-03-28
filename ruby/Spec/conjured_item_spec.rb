require_relative '../conjured_item'
require_relative '../base_item'

describe ConjuredItem do
  let(:conjured_item) { described_class.new('Conjured Pie', 1, 2) }
  let(:conjured_item_quality_one) { described_class.new('Conjured Pie', 1, 2) }

  describe '#update_item' do
    it 'ages the item and decreases the quality by two' do
      expect(conjured_item.update_item).to have_attributes(:sell_in => 0, :quality => 0)
    end

    it 'cannot have quality less than zero' do
      expect(conjured_item_quality_one.update_item.quality).to eq MIN_QUALITY
    end
  end
end
