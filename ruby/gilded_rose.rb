class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|

      return item = item if sulfuras?(item)
      item.sell_in = item.sell_in - 1
      return increase_quality(item) if aged_brie?(item)
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0

            item.quality = item.quality - 1

        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end



      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0

                item.quality = item.quality - 1

            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
    puts "after "
    @items.each do |item|
      puts item
    end
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def backstage?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def increase_quality(item)
    return item.quality = item.quality + 1 if item.quality < 50
  end


end

# let(:sulfuras) { double("item1", @name = "Sulfuras, Hand of Ragnaros", @sell_in = 30, @quality = 50) }
# let(:aged_brie) { double("item2", :name => "Aged Brie", :sell_in => 1, :quality => 0) }
# let(:aged_brie_quality_50) { double("item3", :name => "Aged Brie", :sell_in => 30, :quality => 50) }
# let(:normal_item) { double("item4", @name = "foo", @sell_in = 11, @quality = 50) }
# let(:normal_item_quality_0) { double("item5", :name => "bar", :sell_in => 0, :quality => 0) }
# let(:backstage) { double("item6", :name => "Backstage passes to a TAFKAL80ETC concert", :sell_in => 20, :quality => 0) }
# let(:backstage_10_days) { double("item7", :name => "Backstage passes to a TAFKAL80ETC concert", :sell_in => 10, :quality => 0) }
# let(:backstage_5_days) { double("item8", :name => "Backstage passes to a TAFKAL80ETC concert", :sell_in => 5, :quality => 0) }
# let(:backstage_0_days) { double("item9", :name => "Backstage passes to a TAFKAL80ETC concert", :sell_in => 0, :quality => 50) }
# let(:backstage_quality_50) { double("item10", :name => "Backstage passes to a TAFKAL80ETC concert", :sell_in => 20, :quality => 50) }
#
# before(:each) do
#   items = [ sulfuras, aged_brie, aged_brie_quality_50, normal_item, normal_item_quality_0,
#     backstage, backstage_0_days, backstage_5_days, backstage_10_days, backstage_quality_50 ]
#   gild_rose = GildedRose.new(items)
#   gild_rose.update_quality()
# end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
