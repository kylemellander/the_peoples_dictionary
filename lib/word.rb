class Word
  @@words = []
  @@id_count = 0

  attr_reader(:word, :id)

  define_method(:initialize) do |attributes|
    @word = attributes.fetch(:word, "").downcase()
    @@id_count += 1
    @id = @@id_count
  end

  define_singleton_method(:all) do
    @@words
  end

  define_method(:save) do
    @@words.push(self)
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
end
