class Definition
  @@definitions = []
  @@id_count = 0

  attr_reader(:definition, :word_id, :id)

  define_method(:initialize) do |attributes|
    @definition = attributes.fetch(:definition)
    @word_id = attributes.fetch(:word_id)
    @@id_count += 1
    @id = @@id_count
  end

  define_singleton_method(:all) do
    @@definitions
  end

  define_method(:save) do
    @@definitions.push(self)
  end

  define_singleton_method(:clear) do
    @@definitions = []
    @@id_count = 0
  end

  define_singleton_method(:delete) do |id|
    revised_definitions = []
    @@definitions.each do |definition|
      if definition.id() != id
        revised_definitions.push(definition)
      end
    end
    @@definitions = revised_definitions
  end

  define_singleton_method(:find_by_word_id) do |word_id|
    found_definitions = []
    @@definitions.each do |definition|
      if definition.word_id() == word_id
        found_definitions.push(definition)
      end
    end
    found_definitions
  end
end
