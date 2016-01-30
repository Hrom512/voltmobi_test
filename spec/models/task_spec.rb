require 'rails_helper'

RSpec.describe Task, :type => :model do
  let(:task) { create(:task, state: nil) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_inclusion_of(:state).in_array(%w(new started finished)) }
  end

  it 'have initial state' do
    expect(task.state).to eq('new')
  end
end
