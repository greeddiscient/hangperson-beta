class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  attr_accessor :check_win_or_lose

  def initialize(word)
    @word= word
    @guesses=''
    @wrong_guesses= ''
    @valid=false
    @word_with_guesses= ''
    @word.length.times {@word_with_guesses += "-"}
    @check_win_or_lose= :play
  end

  def guess(l)
    if l=='' or l==nil or !((l >="a" and l<="z")or (l>="A"and l<="Z"))
      raise ArgumentError.new("Can't guess Nothing")
    end

  l.downcase!
  if @guesses.include?l or @wrong_guesses.include?l
    return false
    
  end

    if @word.include? l
      if  not @guesses.include?l and not @wrong_guesses.include?l
        @guesses += l
        @valid=true
        @word.split("").each_with_index do |x, i|
          if x == l
            @word_with_guesses[i]=l
          end
        end
        if not @word_with_guesses.include? '-'
          @check_win_or_lose=:win
            return true
          end
          return true
      end

    else
      if  not @guesses.include?l and not @wrong_guesses.include?l
          @wrong_guesses +=l
          @valid=true
          if @wrong_guesses.length>=7
            @check_win_or_lose=:lose
          end
      end
    
  
    end
    return true
  end




  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess_several_letters(game, letters)
    letters.each do |x|
      game.guess(x)
    end
  end
end
