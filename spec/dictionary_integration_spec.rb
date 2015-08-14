require("capybara/rspec")
require("./app")
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('dictionary site', {:type => :feature}) do
  before() do
    Word.clear()
    Definition.clear()
  end

  it("successfully loads index page from root") do
    visit('/')
    expect(page).to have_content("The People's Dictionary")
  end

  it("successfully adds a word to the homepage") do
    visit('/')
    fill_in("word", :with => "Spry")
    click_button("Add Word")
    expect(page).to have_content("Spry")
  end

  it("successfully displays list of words added on homepage") do
    visit('/')
    fill_in("word", :with => "Spry")
    click_button("Add Word")
    click_link("The People's Dictionary")
    expect(page).to have_content("spry")
  end

  it("successfully displays the page of an individual word when clicked") do
    Word.new({:word => "Spry"}).save()
    visit('/')
    click_link("spry")
    expect(page).to have_content("Spry")
    expect(page).to have_content("Definitions:")
  end

  it("successfully adds a definition to a word") do
    Word.new({:word => "Spry"}).save()
    visit('/word/1')
    fill_in("definition", :with => "Quick; Agile")
    click_button("Add Definition")
    expect(page).to have_content("Quick; Agile")
  end

  it("successfully deletes a word") do
    Word.new({:word => "Spry"}).save()
    visit('/word/1/delete')
    visit('/')
    expect(page).to have_no_content("spry")
  end

  it("successfully deletes a definition") do
    Word.new({:word => "Spry"}).save()
    Definition.new({:definition => "Quick", :word_id => 1})
    visit('/word/1/1/delete')
    expect(page).to have_no_content("Quick")
  end

  it("displays an error and the index page if an incorrect word is inputted") do
    visit('/')
    fill_in("word", :with => "Spry!")
    click_button("Add Word")
    expect(page).to have_no_content("spry!")
    expect(page).to have_content("You can only use letters to add a word (no spaces or special characters)")
  end

  it("displays a success message if successfully added word") do
    visit('/')
    fill_in("word", :with => "Spry")
    click_button("Add Word")
    expect(page).to have_content("Spry")
    expect(page).to have_content("You have successfully added the word ")
  end

  it("displays a success message when a definition is added") do
    Word.new({:word => "Spry"}).save()
    visit('/word/1')
    fill_in("definition", :with => "Quick; Agile")
    click_button("Add Definition")
    expect(page).to have_content("You have successfully added the definition: ")
  end
end
