require './item'

MAX_QUALITY = 50
MIN_QUALITY = 0

class BaseItem < Item
  def age_item
    @sell_in -= 1
  end

  def update_item
    age_item
    @quality -= 1 if @quality > MIN_QUALITY
    self
  end
end
