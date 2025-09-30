class WordGuesserGame
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  attr_accessor :word, :guesses, :wrong_guesses

  def guess(letter)
    # Validate input - raise ArgumentError for nil or empty
    raise ArgumentError, 'Invalid guess.' if letter.nil? || letter.empty?
    
    letter = letter.downcase
    
    # Check if it's a valid letter (a-z only)
    raise ArgumentError, 'Invalid guess.' unless letter.match?(/[a-z]/)
    
    # Check if already guessed - return false (not an error)
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)
    
    # Process the valid new guess
    if @word.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    
    true  # Return true for successful new guess
  end

  def word_with_guesses
    displayed = ''
    @word.each_char do |char|
      if @guesses.include?(char)
        displayed += char
      else
        displayed += '-'
      end
    end
    displayed
  end

  def check_win_or_lose
    return :win if word_with_guesses == @word
    return :lose if @wrong_guesses.length >= 7
    :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end
end