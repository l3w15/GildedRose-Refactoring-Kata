require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "makes no change to Sulfuras" do
      item =Item.new("Sulfuras, Hand of Ragnaros", 30, 50)
      items = [item]
      GildedRose.new(items).update_quality()
      expect(item).to have_attributes(:sell_in => 30, :quality => 50)
    end
  end

  describe "check behaviour of all items" do
    it "doesn't delete items" do
      items = [
        Item.new("Sulfuras, Hand of Ragnaros", 40, 50),
        Item.new("Aged Brie", 20, 20),
        Item.new("Test no negative", -20, 0),
        Item.new("Aged Brie", 10, 50),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 50),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 30),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 30),
        Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 30)
      ]
      GildedRose.new(items).update_quality();
      expect(items.length).to eq(8);
    end
  end


end
