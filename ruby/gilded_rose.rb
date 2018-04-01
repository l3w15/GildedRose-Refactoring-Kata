require_relative 'legendary_item'
require_relative 'maturing_item'
require_relative 'deadline_item'
require_relative 'conjured_item'

class GildedRose
  ITEM_TYPES = {
    'aged' => MaturingItem,
    'concert' => DeadlineItem,
    'sulfuras' => LegendaryItem,
    'conjured' => ConjuredItem
  }.freeze

  attr_reader :updated_items

  def initialize(items)
    @items = items
    @updated_items = []
    @item_type = BaseItem
  end

  def update_quality
    @items.each do |item|
      ITEM_TYPES.each do |key, value|
        @item_type = value if item.name.downcase.include? key
      end
      item = @item_type.new(item.name, item.sell_in, item.quality)
      @updated_items.push(item.update_item)
    end
    @updated_items
  end
end
