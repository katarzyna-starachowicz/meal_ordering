require 'rails_helper'

describe Meal do
  describe 'validation' do
    let(:user)  { User.create!(name: 'Eric Blue', uid: 1234, provider: 'github') }
    let(:order) { Order.create!(restaurant_link: 'http://kfc.pl/',  restaurant_name: 'kfc', status: 'booking') }

    it 'requires name presence' do
      expect(described_class.new(price: 2.22, order_id: order.id, client_id: user.id).valid?).to be false

      expect { described_class.create!(price: 2.22, order_id: order.id, client_id: user.id) }.
        to raise_error(ActiveRecord::RecordInvalid).
        with_message("Validation failed: Name can't be blank")
    end

    it 'requires price presence' do
      expect(described_class.new(name: 'Tomato soup', order_id: order.id, client_id: user.id).valid?).
        to be false

      expect { described_class.create!(name: 'Tomato soup', order_id: order.id, client_id: user.id) }.
        to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'has always a price as a number' do
      meal = described_class.new(price: '2.22')

      expect(meal.price).to eq(2.22)
    end

    it 'has always two decimal places' do
      meal = described_class.new(price: '2.2222222')

      expect(meal.price).to eq(2.22)
    end

    context 'when user booked one meal in order' do
      before { user.meals.create!(name: 'Soup', price: 5.45, order_id: order.id) }

      it 'does not allow user to take the second one meal' do
        expect { user.meals.create!(name: 'Pizza', price: 35.22, order_id: order.id) }.
          to raise_error(ActiveRecord::RecordInvalid).
          with_message('Validation failed: You can book only one meal per order')
      end
    end

    context 'when order does not have booking status' do
      before { order.update(status: 'finalized') }

      it 'does not allow to add meal to the order' do
        expect { user.meals.create!(name: 'Pizza', price: 35.22, order_id: order.id) }.
          to raise_error(ActiveRecord::RecordInvalid).
          with_message('Validation failed: You can book meal only when order has booking status')
      end
    end

    context 'when order was deleted' do
      before { order.update(deleted_at: Time.now) }

      it 'does not allow to add meal to the order' do
        expect { user.meals.create!(name: 'Pizza', price: 35.22, order_id: order.id) }.
          to raise_error(ActiveRecord::RecordInvalid).
          with_message('Validation failed: You can not book a meal in deleted order')
      end
    end
  end
end
