require "sinatra"
require "sinatra/reloader"


@@number = rand(100)

get '/' do
  guess = params['guess'].to_i
  status = check_guess(guess)
  background_colour = set_background(status)
  message = set_message(status)
  #renders the ERB template named index and creates local variable for template
  #named number which has same value as the number variable from this server code.
  erb :index, :locals => {:number => @@number, :message => message, :background_colour => background_colour }
end

def check_guess(guess)
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
    :correct => "green"
  }
  background[status]
end

def set_message(status)
  message = {
    :too_high => "Way too high!",
    :high => "Too high!",
    :too_low => "Way too low!",
    :low => "Too low!",
    :correct => "Congrats!\nThe secret number is #{@@number}"
  }
  message[status]
end
