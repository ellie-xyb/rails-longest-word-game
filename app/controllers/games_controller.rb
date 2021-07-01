require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample }
  end

  def score
    word_arr = params[:word].split(//)
    grid_arr = params[:letters].chars
    if overflow?(word_arr, grid_arr)
      @result = "Sorry but #{word_arr.join.upcase} can't built out of #{grid_arr.join(', ')}"
    elsif !valid_word?(word_arr.join)
      @result = "Sorry but #{word_arr.join.upcase} does not seem to be a valid English word"
    else
      @result = "Congratulations! #{word_arr.join.upcase} is a valid English word!"
    end
  end

  def overflow?(guess, grid)
    guess.all? { |letter| guess.count(letter) > grid.count(letter) }
  end

  def valid_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    JSON.parse(URI.open(url).read)['found']
  end
end
