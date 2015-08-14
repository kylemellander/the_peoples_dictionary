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

  describe(".all") do
    it("returns empty when calling .all method on Word") do
      expect(Word.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("successfully saves a word to the Word class") do
      test_word = Word.new({:name => "Spry"})
      test_word.save()
      expect(Word.all()).to(eq([test_word]))
    end
  end
end
