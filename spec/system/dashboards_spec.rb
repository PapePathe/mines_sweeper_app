require 'rails_helper'

RSpec.describe "Dashboards", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'can create a new board' do
    visit "/" 

    fill_in :email, with: "pathe.sene@gmail.com"
    fill_in :board_width, with: 100
    fill_in :board_height, with: 80
    fill_in :number_of_mines, with: 140 
    fill_in :board_name, with: "my board" 

    click_button "Generate Board"


    last_board = Board.last

    expect(current_path).to eq(board_path(last_board.id))
    expect(page).to have_content("pathe.sene@gmail.com")
    expect(page).to have_content("my board")
  end
end
