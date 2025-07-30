require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to :user }
    it { should have_many(:order_items).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:total_price) }
  end
end
