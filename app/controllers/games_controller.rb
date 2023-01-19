require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def score
    @letters = params[:letters].downcase
    @word = params[:word].downcase
      #   # def score_and_message(attempt, grid, time)
      # if included?(@attempt.upcase, grid)
    if english_word?(@word) && included?(@word, @letters)
      @answer = 'Well done!'
    elsif included?(@word, @letters)
      @answer = "Nice try but #{@word} is not a valid English word"
    elsif english_word?(@word)
      @answer = "Please use letters from the grid"
    else
      @answer = "Nice try!"
    end
    #     @answer = compute_answer(@attempt)
    #     [@answer, "well done"]
    #   else
    #     [0, "not an english word"]
    #   end
    # else
    #   [0, "not in the grid"]
    # end
  end

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @letters.shuffle!
  end
  # def score
  #   @message = params[:word]
  #   if @message == "hello"
  #     @response = "Well done"
  #   end
  # end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included?(word, letters)
    word.chars.each do |character|
     if letters.include?(character)
      letters.delete(character)
     else
      return false
     end
    end
    # word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end


end




  # def included?(guess, grid)
  #   guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  # end

  # def compute_score(attempt, time_taken)
  #   time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
  # end

  # def run_game(attempt, grid, start_time, end_time)
  #   # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
  #   result = { time: end_time - start_time }
  #   score_and_message = score_and_message(attempt, grid, result[:time])
  #   result[:score] = score_and_message.first
  #   result[:message] = score_and_message.last
  #   result
  # end
  # def score_and_message(attempt, grid, time)
    #   if included?(attempt.upcase, grid)
  #     if english_word?(attempt)
  #       score = compute_score(attempt, time)
  #       [score, "well done"]
  #     else
  #       [0, "not an english word"]
  #     end
  #   else
  #     [0, "not in the grid"]
  #   end
  # end
  # def english_word?(word)
  #   response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
  #   json = JSON.parse(response.read)
  #   return json['found']
  # end
