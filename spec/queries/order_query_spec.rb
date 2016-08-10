require 'rails_helper'

describe OrderQuery do
  before do
    Order.create!(restaurant_link: 'http://kfc.pl/',  restaurant_name: 'kfc',  status: 'booking')
    Order.create!(restaurant_link: 'http://soup.pl/', restaurant_name: 'soup', status: 'ordered')
    Order.create!(restaurant_link: 'http://mcd.pl/',  restaurant_name: 'mcd',  status: 'booking')
    Order.create!(
      restaurant_link: 'http://egg.pl/',
      restaurant_name: 'egg',
      status:          'ordered',
      deleted_at:      Time.now
    )
  end

  describe '#active' do
    it 'returns active orders chronologically ordered' do
      expect(described_class.new.active.map(&:restaurant_name)).to eq(%w(mcd kfc))
    end
  end

  describe '#history' do
    it 'returns history orders chronologically ordered' do
      expect(described_class.new.history.map(&:restaurant_name)).to eq(%w(egg soup))
    end
  end
end
