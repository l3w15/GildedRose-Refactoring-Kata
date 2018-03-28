class GildedRose

  # GET_ITEM_TYPE = { MaturingItem => "Aged Brie" }

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      # item = GET_ITEM_TYPE.key(item.name).new(item.name, item.sell_in, item.quality) #{ |k, v| v.include?(item.name) }
      # puts item
      # item = type.new(item.name, item.sell_in, item.quality)
      # puts "item is " + item

      item = item if sulfuras?(item)
      item.sell_in = item.sell_in - 1
      MaturingItem::update_item if aged_brie?(item)
      increase_quality(item) if backstage?(item) && item.sell_in > 10
      backstage_quality(item) if backstage?(item)
      decrease_quality(item)
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
    item.quality += 1 if item.quality < 50
  end

  def backstage_quality(item)
    item.quality += 2 if item.sell_in > 5 && item.quality < 50
    item.quality += 3 if item.sell_in >= 0 && item.quality < 50
    item.quality = 0
  end

  def decrease_quality(item)
    return item.quality -= 2 if item.quality > 0 && item.name.downcase.include?("conjured")
    return item.quality = item.quality - 1 if item.quality > 0
  end
end

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

class BaseItem < Item
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def age_item
    @sell_in -= 1
  end

  def update_item
    age_item
    @quality -= 1 if @quality > MIN_QUALITY
  end
end

class MaturingItem < BaseItem
  def update_item
    age_item
    @quality += 1 if @quality < MAX_QUALITY
  end
end

class LegendaryItem < Item
    def update_item
    end
end

class DeadlineItem < BaseItem
  DOUBLE_QUALITY_DAYS = 10
  TRIPLE_QUALITY_DAYS = 5
  LAST_DAY = 0

  def update_item
    age_item
    @sell_in > LAST_DAY ? quality_add_one : @quality = 0
  end

  def quality_add_one
    @sell_in > DOUBLE_QUALITY_DAYS && @quality < MAX_QUALITY - 1 ? @quality += 1 : quality_add_two
  end

  def quality_add_two
    @sell_in > TRIPLE_QUALITY_DAYS && @quality < MAX_QUALITY - 2 ? @quality += 2 : quality_add_three
  end

  def quality_add_three
    @quality += 3 if @sell_in > LAST_DAY && @quality < MAX_QUALITY - 3 
  end
end
