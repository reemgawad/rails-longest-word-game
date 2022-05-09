require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    # raise
    @word = params[:word].upcase
    grid = params[:grid].split(' ')
    # if input is a valid word & in grid
    # then Congrats, input is a valid English word
    # elsif input is not a valid word
    # then sorry but input does not seem to be an English word
    # else, sorry but input can't be built out of grid
    if engl_word?(@word) && in_grid?(@word, grid)
      @display = "Congratulations! #{@word} is a valid English word!"
    elsif engl_word?(@word) == false
      @display = "Sorry, but #{@word} does not seem to be an English word..."
    else
      @display = "Sorry, but #{@word} can't be built out of #{grid.join(' ')}..."
    end
  end

  private

  def in_grid?(word, grid)
    # check if grid includes each letter in word
    count = 0
    word.upcase.chars.each do |char|
      count += 1 if grid.include?(char)
    end
    count == word.size
  end

  def engl_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    result = JSON.parse(URI.open(url).read)
    result['found']
  end
end
