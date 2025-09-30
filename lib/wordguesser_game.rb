class WordGuesserGame
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  attr_accessor :word, :guesses, :wrong_guesses

  def guess(letter)
    if letter.nil? || letter.to_s.empty? || !(letter =~ /^[a-zA-Z]$/)
      return "Invalid guess."
    end

    letter = letter.downcase

    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return "You have already used that letter."
    end

    if @word.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end

    ""  
  end

  def guess_with_exception(letter)
    result = guess(letter)

    case result
    when "Invalid guess."
      raise ArgumentError, "Invalid guess."
    when "You have already used that letter."
      false
    else
      true
    end
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
