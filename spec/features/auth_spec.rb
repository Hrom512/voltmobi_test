require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Auth', :type => :feature do
  let(:user) { create(:user, password: password) }
  let(:password) { 'user_password' }

  describe 'Login' do
    let(:input_password) { password }

    before do
      visit new_user_session_path
      within('form#new_user') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: input_password
      end
      click_button 'Log in'
    end

    context 'with valid password' do
      it 'show message' do
        expect(page).to have_css('.alert', text: 'Signed in successfully')
      end

      it 'have logout button' do
        expect(page).to have_css('a.logout', text: 'Logout')
      end
    end

    context 'with invalid password' do
      let(:input_password) { 'invalid' }

      it 'show error' do
        expect(page).to have_css('.alert', text: 'Invalid email or password')
      end

      it 'have not logout button' do
        expect(page).not_to have_css('a.logout')
      end
    end
  end

  describe 'Logout' do
    before do
      login_as(user)
      visit root_path
      click_link 'Logout'
    end

    it 'show message' do
      expect(page).to have_css('.alert', text: 'Signed out successfully')
    end

    it 'have login link' do
      expect(page).to have_css('a.login', text: 'Login')
    end
  end
end
