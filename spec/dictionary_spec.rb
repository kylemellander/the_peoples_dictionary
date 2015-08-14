require("rspec")
require("word")
require("definition")

describe(Word) do
  before() do
    Word.clear()
  end

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

  describe(".clear") do
    it("clears all words that have been saved") do
      test_word = Word.new({:name => "Spry"})
      test_word.save()
      Word.clear()
      expect(Word.all()).to(eq([]))
    end
  end

  describe(".delete") do
    it("deletes a single word from the Word class") do
      test_word = Word.new({:name => "Spry"})
      test_word2 = Word.new({:name => "Peppy"})
      test_word.save()
      test_word2.save()
      Word.delete(2)
      expect(Word.all()).to(eq([test_word]))
    end
  end

  describe(".find") do
    it("finds a single word by id number") do
      test_word = Word.new({:name => "Spry"})
      test_word2 = Word.new({:name => "Peppy"})
      test_word.save()
      test_word2.save()
      expect(Word.find(2)).to(eq(test_word2))
    end
  end
end
