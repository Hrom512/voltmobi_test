require 'rails_helper'

RSpec.feature 'Profile', :type => :feature do
  let!(:user) { create(:user) }

  let!(:task) { create(:task, user: user) }
  let!(:other_task) { create(:task) }

  before do
    login_as user
    visit root_path
    click_link 'Profile'
  end

  describe 'show profile' do
    it 'have user tasks' do
      within('#content #tasks') do
        expect(page).to have_css('.task', count: 1)

        within page.find('.task') do
          expect(page).to have_css('.name', text: task.name)
          expect(page).to have_css('.state', text: Task.human_attribute_name("state.#{task.state}"))
          expect(page).to have_css('.description', text: task.description)
        end
      end
    end
  end

  describe 'show task' do
    it 'have task info' do
      click_link task.name

      within('#content') do
        expect(page).to have_css('h1', text: task.name)
        expect(page).to have_css('.state', text: Task.human_attribute_name("state.#{task.state}"))
        expect(page).to have_css('.description', text: task.description)
      end
    end
  end

  describe 'new task' do
    context 'with invalid data' do
      it 'have errors' do
        click_link 'New task'
        click_button 'Save'

        expect(page).to have_css('.alert', text: 'Name can\'t be blank')
      end
    end

    context 'with valid data' do
      let(:task_name) { 'New task name' }

      it 'create task' do
        click_link 'New task'
        within('#content form.new_task') do
          fill_in 'Name', with: task_name
        end
        click_button 'Save'

        within('#content #tasks') do
          expect(page).to have_css('.task', count: 2)
          expect(page).to have_css('.task .name', text: task_name)
        end
      end
    end
  end

  describe 'edit task' do
    context 'with invalid data' do
      it 'have errors' do
        click_link 'Edit'
        within('#content form.edit_task') do
          fill_in 'Name', with: ''
        end
        click_button 'Save'

        expect(page).to have_css('.alert', text: 'Name can\'t be blank')
      end
    end

    context 'with valid data' do
      let(:task_name) { 'New task name' }

      it 'create task' do
        click_link 'Edit'
        within('#content form.edit_task') do
          fill_in 'Name', with: task_name
        end
        click_button 'Save'

        within('#content #tasks') do
          expect(page).to have_css('.task', count: 1)
          expect(page).to have_css('.task .name', text: task_name)
        end
      end
    end
  end

  describe 'delete task' do
    context 'when accept confirm' do
      it 'delete task' do
        accept_confirm do
          click_link 'Destroy'
        end

        within('#content') do
          expect(page).not_to have_css('#tasks')
          expect(page).to have_css('.alert', text: 'Tasks not found')
        end
      end
    end

    context 'when dismiss confirm' do
      it 'not delete task' do
        dismiss_confirm do
          click_link 'Destroy'
        end

        within('#content #tasks') do
          expect(page).to have_css('.task', count: 1)
          expect(page).to have_css('.task .name', text: task.name)
        end
      end
    end
  end
end
