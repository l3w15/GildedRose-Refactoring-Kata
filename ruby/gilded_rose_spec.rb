require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  let(:sulfuras) { double("item", :name => "Sulfuras, Hand of Ragnaros", :sell_in => 30, :quality => 50) }
  before(:each) do

  end

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    describe "Sulfuras" do
      it "never changes" do

        GildedRose.new([sulfuras]).update_quality()
        expect(sulfuras).to have_attributes(:sell_in => 30, :quality => 50)
      end
    end

    describe "a normal item" do
      it "ages and decreases in quality" do
        item = Item.new("ham", 11, 50)
        GildedRose.new([item]).update_quality()
        expect(item).to have_attributes(:sell_in => 10, :quality => 49)
      end

      it "never has quality of below zero" do
        item = Item.new("beef", 0, 0)
        GildedRose.new([item]).update_quality()
        expect(item).to have_attributes(:sell_in => -1, :quality => 0)
      end
    end

    describe "Aged Brie" do
      it "increases in quality the older it gets" do
        item = Item.new("Aged Brie", 1, 0)
        GildedRose.new([item]).update_quality()
        expect(item).to have_attributes(:sell_in => 0, :quality => 1)
      end

      it "never has quality over 50" do
        item = Item.new("Aged Brie", 0, 50)
        GildedRose.new([item]).update_quality()
        expect(item).to have_attributes(:sell_in => -1, :quality => 50)
      end
    end

    describe "Backstage Pass" do
      it "increases in quality the older it gets" do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 0)
        GildedRose.new([item]).update_quality()
        expect(item).to have_attributes(:sell_in => 19, :quality => 1)
      end

      it "increases by 2 within 10 days" do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 0)
        GildedRose.new([item]).update_quality()
        expect(item).to have_attributes(:sell_in => 9, :quality => 2)
      end

      it "increases by 2 within 5 days" do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 0)
        GildedRose.new([item]).update_quality()
        expect(item).to have_attributes(:sell_in => 4, :quality => 3)
      end

      it "drops to zero after the concert" do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 40)
        GildedRose.new([item]).update_quality()
        expect(item).to have_attributes(:sell_in => -1, :quality => 0)
      end

      it "never has quality over 50" do
        item = Item.new("Aged Brie", 10, 50)
        GildedRose.new([item]).update_quality()
        expect(item).to have_attributes(:sell_in => 9, :quality => 50)
      end
    end

    # describe "#sulfuras?" do
    #   it "returns true if the item is Sulfuras" do
    #     expect(GildedRose.new.sulfuras?(Item.new("Sulfuras, Hand of Ragnaros", 30, 50)).to eq(true))
    #   end
    #
    #   it "returns false if the item is not Sulfuras" do
    #     expect(GildedRose.new.sulfuras?(Item.new("foo", 30, 50)).to eq(false))
    #   end
    # end


  end
  #
  # describe "check behaviour of all items" do
  #   it "doesn't delete items" do
  #     items = [
  #       Item.new("Sulfuras, Hand of Ragnaros", 40, 50),
  #       Item.new("Aged Brie", 20, 20),
  #       Item.new("Test no negative", -20, 0),
  #       Item.new("Aged Brie", 10, 50),
  #       Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 50),
  #       Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 30),
  #       Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 30),
  #       Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 30)
  #     ]
  #     GildedRose.new(items).update_quality();
  #     expect(items.length).to eq(8);
  #   end
  # end
  #

  # TODO: makemore doubles then before each gild_rose = GR.new(items)

end
