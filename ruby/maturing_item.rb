require './base_item'

class MaturingItem < BaseItem
  def update_item
    age_item
    @quality += 1 if @quality < MAX_QUALITY
    self
  end
end
