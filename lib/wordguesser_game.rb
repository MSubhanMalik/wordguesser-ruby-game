class WordGuesserGame
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  attr_accessor :word, :guesses, :wrong_guesses

  def guess(letter)
    raise ArgumentError, 'Invalid guess.' if letter.nil? || letter.empty?
    
    letter = letter.downcase
    
    raise ArgumentError, 'Invalid guess.' unless letter.match?(/[a-z]/)
    
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)
    
    if @word.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    
    true  
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