# require '../legendary_item'

describe LegendaryItem do
  let(:sulfuras) { described_class.new("Sulfuras, Hand of Ragnaros", 0, 80) }

  describe '#update_item' do
    it 'Changes nothing!' do
      expect(sulfuras.update_item).to eq sulfuras
    end
  end
end
