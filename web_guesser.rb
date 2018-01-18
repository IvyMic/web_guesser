require "sinatra"
require "sinatra/reloader"


@@number = rand(100)

get '/' do
  guess = params['guess'].to_i
  message = check_guess(guess)
  #renders the ERB template named index and creates local variable for template
  #named number which has same value as the number variable from this server code.
  erb :index, :locals => {:number => @@number, :message => message }
end

def check_guess(guess)
  if guess > @@number
    if (guess - @@number) > 15
      return "Way too high!"
    else
      return "Too high!"
    end
  elsif guess < @@number
    if (@@number - guess) > 15
      return "Way too low!"
    else
      return "Too low!"
    end
  elsif @@number == guess
    return "Congrats!\nThe secret number is #{@@number}"
  end
end
