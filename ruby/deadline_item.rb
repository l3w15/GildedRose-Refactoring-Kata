require './base_item'

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
