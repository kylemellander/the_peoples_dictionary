class Word
  @@words = []
  @@id_count = 0

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name, "").downcase()
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
end
