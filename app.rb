require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
require("./lib/word")
require("./lib/definition")
also_reload("lib/**/*.rb")

get ('/') do
  erb(:index)
end

post ('/word/add') do
  @word = Word.new({:word => params.fetch('word')})
  @word.save()
  if @word.error_check() == 1
    erb(:index)
  else
    @success_message = "#{@word.word} has been added."
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
  id = params.fetch('id').to_i
  word = Word.find(id)
  @success = 1
  @message = "You have successfully deleted the word '" + word.word() + "'."
  Word.delete(id)
  erb(:index)
end

get ('/word/:word_id/:id/delete') do
  id = params.fetch('id').to_i
  @success = 1
  @message = "You have successfully deleted the definition '" + Definition.find(id).definition() + "'."
  Definition.delete(id)
  @word = Word.find(params.fetch('word_id').to_i)
  erb(:word)
end

get ('/word/:word_id/:id/upvote') do
  id = params.fetch('id').to_i
  Definition.upvote(id)
  @word = Word.find(params.fetch('word_id').to_i)
  erb(:word)
end

get ('/word/:word_id/:id/downvote') do
  id = params.fetch('id').to_i
  Definition.downvote(id)
  @word = Word.find(params.fetch('word_id').to_i)
  erb(:word)
end
