require 'spec_helper'
require_relative '../item'

describe Item do
  describe '#to_s' do
    it 'returns a string of the initialized item' do
      item = described_class.new('humbug', 1, 1)
      expect(item.to_s).to eq 'humbug, 1, 1'
    end
  end
end
