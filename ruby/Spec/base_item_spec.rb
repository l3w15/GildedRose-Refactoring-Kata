require 'spec_helper'
require_relative '../base_item'

describe BaseItem do
  let(:normal_item) { described_class.new('Ham', 1, 1) }
  let(:normal_item_quality_zero) { described_class.new('beef', 0, 0) }

  describe '#update_item' do
    it 'ages the item and decreases the quality' do
      expect(normal_item.update_item).to have_attributes(:sell_in => 0, :quality => 0)
    end

    it 'never has quality less than zero' do
      expect(normal_item_quality_zero.update_item.quality).to eq 0
    end
  end
end
