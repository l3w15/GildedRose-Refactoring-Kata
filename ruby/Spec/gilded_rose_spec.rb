require File.join(File.dirname(__FILE__), '../gilded_rose')

describe GildedRose do

  describe "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
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

  end
end
