require("rspec")
require("word")
require("definition")

describe(Word) do
  describe("#initialize") do
    it("creates a new word class object") do
      test_word = Word.new({:name => "Spry"})
      expect(test_word.name()).to(eq("spry"))
      expect(test_word.id()).to(eq(1))
    end
  end
end
