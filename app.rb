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
  if @word.error() == 1
    erb(:index)
  else
    @success = 1
    @message = @word.message()
    erb(:word)
  end
end

get ('/word/:id') do
  @word = Word.find(params.fetch("id").to_i)
  erb(:word)
end

post ('/word/:word_id/definition/add') do
  @word = Word.find(params.fetch("word_id").to_i)
  definition = Definition.new({:definition => params.fetch("definition"), :word_id => @word.id()})
  definition.save()
  @success = 1
  @message = 'You have successfully added the definition: "' + definition.definition() + '"'
  erb(:word)
end

get ('/word/:id/delete') do
  Word.delete(params.fetch('id').to_i)
  erb(:index)
end

get ('/word/:word_id/:id/delete') do
  Definition.delete(params.fetch('id').to_i)
  @word = Word.find(params.fetch('word_id').to_i)
  erb(:word)
end
