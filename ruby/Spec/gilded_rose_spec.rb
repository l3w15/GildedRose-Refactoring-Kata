require_relative 'spec_helper'
require File.join(File.dirname(__FILE__), '../gilded_rose')

describe GildedRose do
  let(:conjured_item) { double('a conjured item', name: 'Chilled Conjured Water', sell_in: 1, quality: 2) }
  let(:base_item) { double('a normal item', name: '+1 Defence Boarhide jacket', sell_in: 1, quality: 1) }
  let(:aged_stilton) { double('a maturing item', name: 'Aged Stilton', sell_in: 2, quality: 0) }
  let(:legendary_item) { double('a legendary item', name: 'Eye of Sulfuras', sell_in: 0, quality: 60) }
  let(:deadline_item) { double('a deadline item', name: 'Blight Boar Concert Pass', sell_in: 15, quality: 20) }
  let(:deadline_item_10_days) { double('a deadline item', name: 'Blight Boar Concert Pass', sell_in: 10, quality: 20) }
  let(:deadline_item_5_days) { double('a deadline item', name: 'Blight Boar Concert Pass', sell_in: 5, quality: 20) }
  let(:deadline_item_0_days) { double('a deadline item', name: 'Blight Boar Concert Pass', sell_in: 0, quality: 50) }
  let(:deadline_item_max_quality) { double('a deadline item', name: 'Blight Boar Concert Pass', sell_in: 5, quality: 50) }
  let(:conjured_item_zero_quality) { double('a conjured item', name: 'Conjured Croissant', sell_in: 0, quality: 0) }

  let(:items) do
    [base_item, conjured_item, aged_stilton,
     legendary_item, deadline_item, deadline_item_10_days,
     deadline_item_5_days, deadline_item_0_days, deadline_item_max_quality,
     conjured_item_zero_quality]
  end

  let(:gild_rose) { GildedRose.new(items) }

  before(:each) do
    gild_rose.update_quality
  end

  describe '#update_quality' do
    it "doesn't change the name" do
      expect(gild_rose.updated_items[0].name).to eq('+1 Defence Boarhide jacket')
    end

    it 'recognises a conjured item and reduces the quality by 2' do
      expect(gild_rose.updated_items[1].quality).to eq MIN_QUALITY
    end

    it 'increases the quality of maturing items by one' do
      expect(gild_rose.updated_items[2].quality).to eq 1
    end

    it "doesn't change legendary items" do
      expect(gild_rose.updated_items[3].quality).to eq 60
    end

    it "increases a deadline item's quality by one more than 10 days before" do
      expect(gild_rose.updated_items[4].quality).to eq 21
    end

    it "increases a deadline item's quality by two 10 or fewer days before" do
      expect(gild_rose.updated_items[5].quality).to eq 22
    end

    it "increases a deadline item's quality by three 5 or fewer days before" do
      expect(gild_rose.updated_items[6].quality).to eq 23
    end

    it "reduces a deadline item's quality to zero after the deadline" do
      expect(gild_rose.updated_items[7].quality).to eq MIN_QUALITY
    end

    it "doesn't allow quality over max quality" do
      expect(gild_rose.updated_items[8].quality).to eq MAX_QUALITY
    end

    it "doesn't allow less than min quality" do
      expect(gild_rose.updated_items[9].quality).to eq MIN_QUALITY
    end
  end
end
