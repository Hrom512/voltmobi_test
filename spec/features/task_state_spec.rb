require 'rails_helper'

RSpec.feature 'Task state', :type => :feature do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user, state: task_state) }
  let(:task_state) { 'new' }

  before do
    login_as user
    visit task_path(task)
  end

  context 'with new task' do
    it 'can be started' do
      click_link 'Start task'
      expect(page).to have_css('.state', text: 'Started')
    end

    it 'can not be finished' do
      expect(page).not_to have_css('a', text: 'Finish task')
    end
  end

  context 'with started task' do
    let(:task_state) { 'started' }

    it 'can not be started' do
      expect(page).not_to have_css('a', text: 'Start task')
    end

    it 'can be finished' do
      click_link 'Finish task'
      expect(page).to have_css('.state', text: 'Finished')
    end
  end

  context 'with finished task' do
    let(:task_state) { 'finished' }

    it 'can not be started' do
      expect(page).not_to have_css('a', text: 'Start task')
    end

    it 'can not be finished' do
      expect(page).not_to have_css('a', text: 'Finish task')
    end
  end
end
