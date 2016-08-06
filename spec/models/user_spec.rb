require 'rails_helper'

describe User do
  describe 'validation' do
    it 'requires name presence' do
      expect { described_class.create!(uid: 1234, provider: 'github') }.
        to raise_error(ActiveRecord::RecordInvalid).
        with_message("Validation failed: Name can't be blank")
    end

    it 'requires uid presence' do
      expect { described_class.create!(name: 'Eric Blue', provider: 'github') }.
        to raise_error(ActiveRecord::RecordInvalid).
        with_message("Validation failed: Uid can't be blank")
    end

    it 'requires provider presence' do
      expect { described_class.create!(name: 'Eric Blue', uid: 1234) }.
        to raise_error(ActiveRecord::RecordInvalid).
        with_message("Validation failed: Provider can't be blank")
    end
  end
end
