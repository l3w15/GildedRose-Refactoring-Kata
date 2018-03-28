require './legendary_item'
require './maturing_item'
require './deadline_item'

class GildedRose

  ITEM_TYPE = {
    "Aged Brie" => MaturingItem,
    "Backstage passes to a TAFKAL80ETC concert" => DeadlineItem,
    "Sulfuras, Hand of Ragnaros" => LegendaryItem
  }

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item = ITEM_TYPE[item.name] ? ITEM_TYPE[item.name].new(item.name, item.sell_in, item.quality)
        : BaseItem.new(item.name, item.sell_in, item.quality)
      item.update_item
    end
  end

end
