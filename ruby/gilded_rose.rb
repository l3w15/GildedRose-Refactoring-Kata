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

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.map! do |item|
      item = BaseItem.new(item.name, item.sell_in, item.quality)
      ITEM_TYPE.each do |key, value|
        item = value.new(item.name, item.sell_in, item.quality) if item.name.downcase.include? key
      end
      item.update_item
    end
    self
  end

end
