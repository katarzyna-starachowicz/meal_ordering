require 'rails_helper'

describe Meal do
  describe 'validation' do
    it 'requires name presence' do
      expect(described_class.new(price: 2.22).valid?).to be false

      expect { described_class.create!(price: 2.22) }.
        to raise_error(ActiveRecord::RecordInvalid).
        with_message("Validation failed: Name can't be blank")
    end

    it 'requires price presence' do
      expect(described_class.new(name: 'Tomato soup').valid?).to be false

      expect { described_class.create!(name: 'Tomato soup') }.
        to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'has always a price as a number' do
      meal = described_class.new(name: 'Tomato soup', price: '2.22')

      expect(meal.price).to eq(2.22)
    end

    it 'has always two decimal places' do
      meal = described_class.new(name: 'Tomato soup', price: '2.2222222')

      expect(meal.price).to eq(2.22)
    end
  end
end
