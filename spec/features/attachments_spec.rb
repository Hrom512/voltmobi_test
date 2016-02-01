require 'rails_helper'

RSpec.feature 'Attachments', :type => :feature do
  let!(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  before do
    login_as user
    visit task_path(task)
  end

  it 'create, show and destroy attachment' do
    # show attachments
    expect(page).not_to have_css('.attachments')

    # create attachment
    click_link 'Edit'
    click_link 'Add attachment'
    input = page.first('.nested-fields input.form-control')
    attach_file(input[:id], "#{Rails.root}/spec/files/cat.jpg")
    click_button 'Save'

    # show attachments
    click_link task.name
    expect(page).to have_css('.attachments li', count: 1)
    expect(page).to have_css('.attachments li', text: 'cat.jpg')

    # destroy attachment
    click_link 'Edit'
    click_link 'Destroy'
    click_button 'Save'

    # show attachments
    click_link task.name
    expect(page).not_to have_css('.attachments')
  end
end
