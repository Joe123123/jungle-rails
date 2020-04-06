# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) { Category.new(name: 'Test Category') }

  subject do
    described_class.new(name: 'test product',
                        price_cents: 10_000,
                        quantity: 10,
                        category: category)
  end
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
    expect(subject.errors.full_messages).to include("Name can't be blank")
  end
  it 'is not valid without a price' do
    subject.price_cents = nil
    expect(subject).to_not be_valid
    expect(subject.errors.full_messages).to include("Price can't be blank")
  end
  it 'is not valid without a qunatity' do
    subject.quantity = nil
    expect(subject).to_not be_valid
    expect(subject.errors.full_messages).to include("Quantity can't be blank")
  end
  it 'is not valid without a category' do
    subject.category = nil
    expect(subject).to_not be_valid
    expect(subject.errors.full_messages).to include("Category can't be blank")
  end
end
