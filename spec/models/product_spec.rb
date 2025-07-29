require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should belong_to(:category) }
    it { should have_many(:cart_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:discount) }
    it { should validate_presence_of(:available_quantity) }
  end
end
