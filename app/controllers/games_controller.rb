require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end

  def score
    @score = run_game(params[:score], @letters)
  end

  private

  def generate_grid(grid_size)
    charac = ('A'..'Z').to_a
    Array.new(grid_size) { charac.sample }
  end

  def english_word?(word)
    url = "https://dictionary.lewagon.com/#{word}"
    response = URI.parse(url).read
    parsed_response = JSON.parse(response)
    parsed_response['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def run_game(attempt, grid)
    if english_word?(attempt) && included?(attempt, grid)
      "#{attempt} is a valid english word"
    else
      "#{attempt} not an English word"
    end
  end
end
