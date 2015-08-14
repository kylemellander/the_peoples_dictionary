require("sinatra")
require("sinatra/reloader")
require("./lib/word")
require("./lib/definition")
also_reload("lib/**/*.rb")

get ('/') do
  erb(:index)
end

post ('/word/add') do
  @word = Word.new({:word => params.fetch('word')})
  @word.save()
  erb(:word)
end

get ('/word/:id') do
  @word = Word.find(params.fetch("id").to_i)
  erb(:word)
end
