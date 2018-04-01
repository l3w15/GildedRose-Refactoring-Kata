require_relative 'item'

class LegendaryItem < Item
    def update_item
      @sell_in = 0
      self
    end
end
