require 'rails_helper'

RSpec.describe "Dashboards", type: :system do
  before do
    driven_by(:rack_test)
  end

  def send_new_board_request(email, size, mines, name)
    visit "/" 

    fill_in :email, with: email
    fill_in :board_width, with: size[0]
    fill_in :board_height, with: size[1]
    fill_in :number_of_mines, with: mines
    fill_in :board_name, with: name

    click_button "Generate Board"
  end

  it 'cannot create a with negative size' do
    # Negative height
    send_new_board_request("pathe.sene@gmail.com", [100, -80], 90, "test board")

    expect(current_path).to eq(root_path)
    expect(page).to have_content("columns must be greater than zero")

    # Negative width
    send_new_board_request("pathe.sene@gmail.com", [-100, 80], 90, "test board")

    expect(current_path).to eq(root_path)
    expect(page).to have_content("rows must be greater than zero")
  end

  it 'cannot create a board with mines > board size' do
    send_new_board_request("pathe.sene@gmail.com", [100, 80], 9000, "test board")

    expect(current_path).to eq(root_path)
    expect(page).to have_content("number of mines must be less that board size")
  end

  it 'can create a new board' do
    send_new_board_request("pathe.sene@gmail.com", [100, 80], 140, "test board")

    last_board = Board.last

    expect(current_path).to eq(board_path(last_board.id))
    expect(page).to have_content("pathe.sene@gmail.com")
    expect(page).to have_content("test board")
  end
end
