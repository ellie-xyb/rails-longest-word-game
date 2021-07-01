# frozen_string_literal: true

require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample }
  end

  def score
    word_arr = params[:word].chars
    grid_arr = params[:letters].chars
    word = params[:word]
    @result = if in_grid?(word_arr, grid_arr)
                if valid_word?(word)
                  "Congratulations! #{word.upcase} is a valid English word!"
                else
                  "Sorry but #{word.upcase} does not seem to be a valid English word"
                end
              else
                "Sorry but #{word.upcase} can't built out of #{grid_arr.join(', ')}"
              end
  end

  def in_grid?(guess, grid)
    guess.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def valid_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    JSON.parse(URI.open(url).read)['found']
  end
end
