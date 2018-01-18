require "sinatra"
require "sinatra/reloader"
x = rand(101)
get '/' do
  "The SECRET NUMBER is #{x}"
end
