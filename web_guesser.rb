require "sinatra"
require "sinatra/reloader"


@@number = rand(100)
@@guesses = 6

get '/' do
  @@guesses -= 1
  guess = params['guess'].to_i
  cheat = params['cheat']
  status = check_guess(guess)
  background_colour = set_background(status)
  message = set_message(status)
  message = message + "\n it's not that serious, here's the secret number: #{@@number}" if cheat == "true"
  restart if status == :correct || status == :game_over
  #renders the ERB template named index and creates local variable for template
  #named number which has same value as the number variable from this server code.
  erb :index, :locals => {:number => @@number, :message => message, :background_colour => background_colour, :guesses => @@guesses }
end

def restart
  @@number = rand(100)
  @@guesses = 6
end

def check_guess(guess)
  return :start if @@guesses == 5
  return :game_over if @@guesses == 0
  if guess > @@number
    if (guess - @@number) > 15
      return :too_high
    else
      return :high
    end
  elsif guess < @@number
    if (@@number - guess) > 15
      return :too_low
    else
      return :low
    end
  elsif @@number == guess
    return :correct
  end
end

def set_background(status)
  background = {
    :too_high => "red",
    :high => "coral",
    :too_low => "red",
    :low => "coral",
    :correct => "green",
    :game_over => "blue" #why not
  }
  background[status]
end

def set_message(status)
  message = {
    :too_high => "Way too high!",
    :high => "Too high!",
    :too_low => "Way too low!",
    :low => "Too low!",
    :correct => "Congrats!\nThe secret number is #{@@number}!!!\n Play again: ",
    :start => "Have fun!",
    :game_over => "You're out of guesses, unlucky! The secret number is #{@@number}!!!\n Play again: "
  }
  message[status]
end
