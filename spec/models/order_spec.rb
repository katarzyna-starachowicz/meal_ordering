require 'rails_helper'

describe Order do
  describe 'validation' do
    it 'requires restaurant presence' do
      expect { described_class.create!(restaurant_link: 'http://kfc.pl/', status: 'booking') }.
        to raise_error(ActiveRecord::RecordInvalid).
        with_message("Validation failed: Restaurant name can't be blank")
    end

    it 'requires defined status' do
      expect { described_class.create!(restaurant_link: 'http://kfc.pl/', restaurant_name: 'kfc') }.
        to raise_error(ActiveRecord::RecordInvalid).
        with_message('Validation failed: Status is not included in the list')
    end

    it 'requires valid online address to the restaurant' do
      expect { described_class.create!(restaurant_link: 'www:kfc', restaurant_name: 'kfc', status: 'booking') }.
        to raise_error(ActiveRecord::RecordInvalid).
        with_message('Validation failed: Restaurant link is invalid')
    end

    it 'creates record with default nil deleted_at column' do
      order = described_class.create!(restaurant_link: 'http://kfc.pl/', restaurant_name: 'kfc', status: 'booking')
      expect(order.deleted_at).to eq nil
    end
  end

  describe 'scope' do
    before do
      described_class.create!(restaurant_link: 'http://kfc.pl/',  restaurant_name: 'kfc',  status: 'booking')
      described_class.create!(restaurant_link: 'http://soup.pl/', restaurant_name: 'soup', status: 'ordered')
      described_class.create!(
        restaurant_link: 'http://mcd.pl/',
        restaurant_name: 'mcd',
        status:          'booking',
        deleted_at:      Time.now
      )
      described_class.create!(
        restaurant_link: 'http://egg.pl/',
        restaurant_name: 'egg',
        status:          'ordered',
        deleted_at:      Time.now
      )
    end

    context 'active scope' do
      it 'returns not deleted orders with booking staus' do
        expect(described_class.active.map(&:restaurant_name)).to eq(['kfc'])
      end
    end

    context 'history scope' do
      it 'returns all deleted orders and all orders with status other than booking' do
        expect(described_class.history.map(&:restaurant_name)).
          to match_array(%w(mcd soup egg))
      end
    end
  end
end
