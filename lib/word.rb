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
end
