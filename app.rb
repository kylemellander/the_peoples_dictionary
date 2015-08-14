require("sinatra")
require("sinatra/reloader")
require("./lib/word")
require("./lib/definition")
also_reload("lib/**/*.rb")

get ('/') do
  erb(:index)
end

post ('/word/add') do
  @word = params.fetch('word').downcase
  erb(:word)
end
