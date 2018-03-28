require File.join(File.dirname(__FILE__), '../gilded_rose')

describe GildedRose do


  describe "#update_quality" do
   # TODO: test gilded rose with stubs / doubles
    it 'knows a conjured item and reduces the quality by 2' do
      conjured_items = [Item.new('Conjured pie', 1, 2)]
      GildedRose.new(conjured_items).update_quality
      expect(conjured_items[0].quality).to eq 0
    end
  end
end
