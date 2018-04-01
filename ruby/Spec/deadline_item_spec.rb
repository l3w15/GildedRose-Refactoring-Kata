require_relative 'spec_helper'
require_relative '../deadline_item'
require_relative '../base_item'

describe DeadlineItem do
  let(:deadline_item) { described_class.new('Awesome concert tickets', 20, 0) }
  let(:deadline_item_10_days) { described_class.new('Concert tickets', 10, 0) }
  let(:deadline_item_5_days) { described_class.new('Concert tickets', 5, 0) }
  let(:deadline_item_0_days) { described_class.new('Concert tickets', 0, 50) }
  let(:max_qual_deadline_item) { described_class.new('Concert tickets', 5, 50) }

  describe '#update_item' do
    it 'increases the quality by one over 10 days before the deadline' do
      expect(deadline_item.update_item).to have_attributes(sell_in: 19, quality: 1)
    end

    it 'increases the quality by two within 10 days of the deadline' do
      expect(deadline_item_10_days.update_item).to have_attributes(sell_in: 9, quality: 2)
    end

    it 'increases the quality by three within 5 days of the deadline' do
      expect(deadline_item_5_days.update_item).to have_attributes(sell_in: 4, quality: 3)
    end

    it 'sets the quality to zero after the deadline' do
      expect(deadline_item_0_days.update_item).to have_attributes(sell_in: -1, quality: 0)
    end

    it 'cannot have quality over max quality' do
      expect(max_qual_deadline_item.update_item.quality).to eq 50
    end
  end
end
