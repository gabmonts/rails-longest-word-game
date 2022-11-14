require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def attempt_validation_english
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_word = URI.open(url).read
    word_hash = JSON.parse(user_word)
    word_hash['found']
  end

  def attempt_correct_letters
    params[:word].chars.all? { |letter| params[:word].chars.count(letter) <= 10 }
  end

  def score
    @points = params[:word].chars.count
    @correct = attempt_correct_letters
    @valid = attempt_validation_english
    @output = params[:word].split
    @word = params[:word].upcase
  end
end
