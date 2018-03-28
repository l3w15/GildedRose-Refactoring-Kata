require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    describe "Sulfuras" do
      it "never changes" do
        item = LegendaryItem.new("Sulfuras, Hand of Ragnaros", 0, 80)
        item.update_item
        expect(item).to have_attributes(:sell_in => 0, :quality => 80 )
      end
    end

    describe "a normal item" do
      it "ages and decreases in quality" do
        item = BaseItem.new("ham", 11, 50)
        item.update_item
        expect(item).to have_attributes(:sell_in => 10, :quality => 49)
      end

      it "never has quality of below zero" do
        item = BaseItem.new("beef", 0, 0)
        item.update_item
        expect(item).to have_attributes(:sell_in => -1, :quality => 0)
      end
    end

    describe "Aged Brie" do
      it "increases in quality the older it gets" do
        item = MaturingItem.new("Aged Brie", 1, 0)
        item.update_item
        expect(item).to have_attributes(:sell_in => 0, :quality => 1)
      end

      it "never has quality over 50" do
        item = MaturingItem.new("Aged Brie", 0, 50)
        item.update_item
        expect(item).to have_attributes(:sell_in => -1, :quality => 50)
      end
    end

    describe "Backstage Pass" do
      it "increases in quality the older it gets" do
        item = DeadlineItem.new("Backstage passes to a TAFKAL80ETC concert", 20, 0)
        item.update_item
        expect(item).to have_attributes(:sell_in => 19, :quality => 1)
      end

      it "increases by 2 within 10 days" do
        item = DeadlineItem.new("Backstage passes to a TAFKAL80ETC concert", 10, 0)
        item.update_item
        expect(item).to have_attributes(:sell_in => 9, :quality => 2)
      end

      it "increases by 2 within 5 days" do
        item = DeadlineItem.new("Backstage passes to a TAFKAL80ETC concert", 5, 0)
        item.update_item
        expect(item).to have_attributes(:sell_in => 4, :quality => 3)
      end

      it "drops to zero after the concert" do
        item = DeadlineItem.new("Backstage passes to a TAFKAL80ETC concert", 0, 40)
        item.update_item
        expect(item).to have_attributes(:sell_in => -1, :quality => 0)
      end

      it "never has quality over 50" do
        item = DeadlineItem.new("Backstage passes to a TAFKAL80ETC concert", 10, 50)
        item.update_item
        expect(item).to have_attributes(:sell_in => 9, :quality => 50)
      end
    end

    describe "#sulfuras?" do
      it "returns true if the item is Sulfuras" do
        item = Item.new("Sulfuras, Hand of Ragnaros", 30, 80)
        expect(GildedRose.new([item]).sulfuras?(item)).to eq(true)
      end

      it "returns false if the item is not Sulfuras" do
        item = Item.new("foo", 30, 50)
        expect(GildedRose.new([item]).sulfuras?(item)).to eq(false)
      end
    end

    describe "#aged_brie?" do
      it "returns true if the item is Aged Brie" do
        item = Item.new("Aged Brie", 30, 50)
        expect(GildedRose.new([item]).aged_brie?(item)).to eq(true)
      end

      it "returns false if the item is not Aged Brie" do
        item = Item.new("foo", 30, 50)
        expect(GildedRose.new([item]).aged_brie?(item)).to eq(false)
      end
    end

    describe "#backstage?" do
      it "returns true if the item is a backstage pass" do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 30, 50)
        expect(GildedRose.new([item]).backstage?(item)).to eq(true)
      end

      it "returns false if the item is not backstage pass" do
        item = Item.new("foo", 30, 50)
        expect(GildedRose.new([item]).backstage?(item)).to eq(false)
      end
    end

    describe "#increase_quality" do
      it "increases the quality of brie" do
        item = Item.new("Aged Brie", 1, 0)
        expect(GildedRose.new([item]).increase_quality(item)).to eq(1)
      end
    end

    describe "#backstage_quality" do
      it "adds two to passes with sell_in between 10 and 5 days" do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 0)
        expect(GildedRose.new([item]).backstage_quality(item)).to eq(2)
      end

      it "adds three to passes with sell_in between 5 and 0 days" do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 0)
        expect(GildedRose.new([item]).backstage_quality(item)).to eq(3)
      end

      it "sets the quality to zero if the concert day has passed" do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 50)
        expect(GildedRose.new([item]).backstage_quality(item)).to eq(0)
      end
    end

    describe "#decrease_quality" do
      it "decreases normal items\' quality by one" do
        item = Item.new("ham", 1, 1)
        expect(GildedRose.new([item]).decrease_quality(item)).to eq(0)
      end

      it "decreases conjured items\' quality by two" do
        item = Item.new("Conjured ham", 1, 2)
        expect(GildedRose.new([item]).decrease_quality(item)).to eq(0)
      end
    end
  end
end
