class ConjuredItem < BaseItem
  def update_item
    age_item
    @quality -= 2 if @quality > MIN_QUALITY
    @quality = 0 if @quality < MIN_QUALITY
    self
  end
end
