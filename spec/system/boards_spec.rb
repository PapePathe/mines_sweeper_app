require 'rails_helper'

RSpec.describe "Dashboards", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'can search boards by email' do
    boards = FactoryBot.create_list :board, 5
    visit boards_path

    board = boards.first

    fill_in :by_email, with: board.email
    click_button :search

    expect(page).to have_content(board.email)
    expect(page).to have_link(href: board_path(board))

    (boards - [board]).each do |b|
      expect(page).not_to have_content(b.email)
      expect(page).not_to have_link(href: board_path(b))
    end
  end

  it 'can search boards by name'

  it 'can search boards by number of mines' do
    board = FactoryBot.create(:board, number_of_mines: 11)
    board_two = FactoryBot.create(:board, number_of_mines: 10)
    board_three = FactoryBot.create(:board, number_of_mines: 9)

    visit boards_path

    fill_in :by_number_of_mines, with: 10
    click_button :search

    expect(page).to have_content(board.email)
    expect(page).to have_content(board_two.email)
    expect(page).to have_link(href: board_path(board))
    expect(page).to have_link(href: board_path(board_two))

    expect(page).not_to have_content(board_three.email)
    expect(page).not_to have_link(href: board_path(board_three))
  end

  it 'can view all boards' do
    boards = FactoryBot.create_list :board, 10
    visit boards_path

    boards.each do |board|
      expect(page).to have_content(board.name)
      expect(page).to have_content(board.email)
      expect(page).to have_link(href:board_path( board))
    end
  end
end
