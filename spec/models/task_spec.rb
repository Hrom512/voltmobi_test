require 'rails_helper'

RSpec.describe Task, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:attachments) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_inclusion_of(:state).in_array(%w(new started finished)) }
  end

  describe 'states' do
    let(:task) { create(:task, state: nil) }

    it 'have initial state' do
      expect(task.state).to eq('new')
    end

    context 'with initial state' do
      it 'can be started' do
        expect { task.start }.to change(task, :state).to('started')
      end

      it 'can not be finished' do
        expect { task.finish }.not_to change(task, :state)
      end
    end

    context 'with started state' do
      let(:task) { create(:task, state: 'started') }

      it 'can be finished' do
        expect { task.finish }.to change(task, :state).to('finished')
      end
    end

    context 'with finished state' do
      let(:task) { create(:task, state: 'finished') }

      it 'can not be started' do
        expect { task.start }.not_to change(task, :state)
      end
    end
  end
end
