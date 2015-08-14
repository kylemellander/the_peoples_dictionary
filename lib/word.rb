class Word
  @@words = []
  @@id_count = 0

  attr_reader(:word, :id, :error, :success, :message)

  define_method(:initialize) do |attributes|
    @word = attributes.fetch(:word, "").downcase()
    @@id_count += 1
    @id = @@id_count
    @error = 0
    @success = 0
    @message = ""
  end

  define_singleton_method(:all) do
    Word.sort()
    @@words
  end

  define_method(:save) do
    self.error_check()
    if @error != 1
      @success = 1
      @message = "You have successfully added the word " + @word + "."
      @@words.push(self)
    end
  end

  define_singleton_method(:clear) do
    @@words = []
    @@id_count = 0
  end

  define_singleton_method(:delete) do |id|
    revised_words = []
    @@words.each do |word|
      if word.id() != id
        revised_words.push(word)
      else
        Definition.delete_by_word_id(id)
      end
    end
    @@words = revised_words
  end

  define_singleton_method(:find) do |id|
    found_word = nil
    @@words.each do |word|
      if word.id() == id
        found_word = word
      end
    end
    found_word
  end

  define_singleton_method(:sort) do
    @@words.sort!{|a, b| a.word() <=> b.word()}
  end

  define_method(:find_definitions) do
    Definition.find_by_word_id(@id)
  end

  define_method(:error_check) do
    if word()[/[a-zA-Z]+/] != word()
      @error = 1
      @message = "You can only use letters to add a word (no spaces or special characters)"
    end
  end
end
