require 'rails_helper'

RSpec.feature 'Home', :type => :feature do
  describe 'GET /' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }

    let!(:task1) { create(:task, user: user1) }
    let!(:task2) { create(:task, user: user2) }

    it 'have h1' do
      visit root_path
      expect(page).to have_css('#content h1', text: 'Tasks')
    end

    it 'have issues' do
      visit root_path
      within('#content #tasks') do
        expect(page).to have_css('.task', count: 2)

        within page.find('.task', text: task1.name) do
          expect(page).to have_css('.id', text: task1.id)
          expect(page).to have_css('.name', text: task1.name)
          expect(page).to have_css('.user', text: user1.email)
        end

        within page.find('.task', text: task2.name) do
          expect(page).to have_css('.id', text: task2.id)
          expect(page).to have_css('.name', text: task2.name)
          expect(page).to have_css('.user', text: user2.email)
        end
      end
    end
  end
end
