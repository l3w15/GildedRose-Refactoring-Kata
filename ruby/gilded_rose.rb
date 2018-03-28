require './legendary_item'
require './maturing_item'
require './deadline_item'
require './conjured_item'

class GildedRose

  ITEM_TYPE = {
    "aged" => MaturingItem,
    "concert" => DeadlineItem,
    "sulfuras" => LegendaryItem,
    "conjured" => ConjuredItem
  }

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item = BaseItem.new(item.name, item.sell_in, item.quality)
      ITEM_TYPE.each do |key, value|
        item = value.new(item.name, item.sell_in, item.quality) if item.name.downcase.include? key
      end
      puts item::class
      puts item.update_item
    end
  end

end
