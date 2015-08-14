require("capybara/rspec")
require("./app")
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('dictionary site', {:type => :feature}) do
  it("successfully loads index page from root") do
    visit('/')
    expect(page).to have_content("The People's Dictionary")
  end

  it("successfully adds a word to the homepage") do
    visit('/')
    fill_in("word", :with => "Spry")
    click_button("Add Word")
    expect(page).to have_content("spry")
  end
end
