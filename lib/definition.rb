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
end
