require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = alphabet.sample(10)
  end

  def score
    @user_input = params[:user_input]
    @game_letters = params[:game_letters]
    # given_letters = @game_letters.each_char { |letter| print letter, ''}
    if !check_user_input
      @result = "Sorry but #{@user_input.upcase} cannot be built out of #{@game_letters.upcase}"
    elsif !english_word
      @result = "Sorry but #{@user_input.upcase} does not seem to be a valid English word..."
    elsif check_user_input && !english_word
      @result = "Sorry but #{@user_input.upcase} does not seem to be a valid English word..."
    else english_word && check_user_input
      @result = "Congratulations! #{@user_input.upcase} is a valid English word"
    end
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@user_input}"
    dictionary = URI.open(url).read
    word = JSON.parse(dictionary)
    return word['found']
  end

  def check_user_input
    @user_input.chars.all? { |letter| @game_letters.include?(letter) }
  end
end
