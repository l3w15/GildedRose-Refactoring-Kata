require './item'

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
