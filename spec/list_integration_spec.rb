require('capybara/rspec')
require('./app')
require "spec_helper"

Capybara.app = Sinatra::Application
set(:show_exceptions,false)

describe('the path to the add list', {:type => :feature}) do
  it('shows a page with a form to create a new list. On submit, shows a page containing a list of lists.') do
    visit('/list/new')
    fill_in('name', :with => 'Chores')
    click_button('submit')
puts "first test now"
    expect(page).to have_content('Chores')
  end

end

describe('the path to view a list', {:type => :feature}) do

  it('shows a page with the list of lists. Clicking on a list directs user to page listing tasks') do
    test_list = List.new({:name => "Chores", :id => nil})
    test_list.save
    test_task = Task.new({:description => "clean my room", :id => nil, :list_id => test_list.id})
    test_task.save
    visit('/lists')
    click_link(test_list.name)
    expect(page).to have_content(test_task.description)
  end

  it('shows a page with forms to add a task to a list. Clicking submit button shows the user a page with the list of tasks.') do
    test_list = List.new({:name => "Test List", :id => nil})
    test_list.save
    visit("/list/#{test_list.id}/new")
    fill_in('description', :with => 'Wash car')
    click_button('submit')
    expect(page).to have_content('Wash car')
  end

end
