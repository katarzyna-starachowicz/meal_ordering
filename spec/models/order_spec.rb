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
end
