# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @recent_boards = Board.limit(10)
  end
end
