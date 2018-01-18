require "sinatra"
require "sinatra/reloader"


number = rand(100)
get '/' do
  #renders the ERB template named index and creates local variable for template
  #named number which has same value as the number variable from this server code.
  erb :index, :locals => {:number => number}
end
