require("rspec")
require("word")
require("definition")

describe(Word) do
  before() do
    Word.clear()
    Definition.clear()
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
      test_definition = Definition.new({:definition => "Quick; Agile", :word_id => 2})
      test_word.save()
      test_word2.save()
      test_definition.save()
      Word.delete(2)
      expect(Word.all()).to(eq([test_word]))
      expect(Definition.all()).to(eq([]))
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

  describe(".sort") do
    it("sorts words alphabetically") do
      test_word = Word.new({:name => "Spry"})
      test_word2 = Word.new({:name => "Peppy"})
      test_word.save()
      test_word2.save()
      Word.sort()
      expect(Word.all()).to(eq([test_word2, test_word]))
    end
  end

  describe("#find_definitions") do
    it("finds all definitions for a specific word") do
      test_word = Word.new({:name => "Spry"})
      test_word2 = Word.new({:name => "Peppy"})
      test_definition = Definition.new({:definition => "Quick; Agile", :word_id => 1})
      test_word.save()
      test_word2.save()
      test_definition.save()
      expect(test_word.find_definitions()).to(eq([test_definition]))
    end
  end
end

describe(Definition) do
  before() do
    Word.clear()
    Definition.clear()
  end

  describe("#initialize") do
    it("creates new Definition with parameters") do
      test_definition = Definition.new({:definition => "Quick; Agile", :word_id => 1})
      expect(test_definition.definition()).to(eq("Quick; Agile"))
      expect(test_definition.id()).to(eq(1))
      expect(test_definition.word_id()).to(eq(1))
    end
  end

  describe(".all") do
    it("returns empty array when no definitions exist") do
      expect(Definition.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("successfully saves a word to the Definition class") do
      test_definition = Definition.new({:definition => "Quick; Agile", :word_id => 1})
      test_definition.save()
      expect(Definition.all()).to(eq([test_definition]))
    end
  end

  describe(".clear") do
    it("clears all definitions that have been saved") do
      test_definition = Definition.new({:definition => "Quick; Agile", :word_id => 1})
      test_definition.save()
      Definition.clear()
      expect(Definition.all()).to(eq([]))
    end
  end

  describe(".delete") do
    it("deletes a single definition from the Definition class") do
      test_definition = Definition.new({:definition => "Quick; Agile", :word_id => 1})
      test_definition2 = Definition.new({:definition => "Energetic and happy.", :word_id => 2})
      test_definition.save()
      test_definition2.save()
      Definition.delete(2)
      expect(Definition.all()).to(eq([test_definition]))
    end
  end

  describe(".find") do
    it("finds a definition by id") do
      test_definition = Definition.new({:definition => "Quick; Agile", :word_id => 1})
      test_definition.save()
      expect(Definition.find(1)).to(eq(test_definition))
    end
  end

  describe(".find_by_word_id") do
    it("finds all the definitions that are associated with a word id") do
      test_word = Word.new({:name => "Spry"})
      test_definition = Definition.new({:definition => "Quick; Agile", :word_id => 1})
      test_word.save()
      test_definition.save()
      expect(Definition.find_by_word_id(1)).to(eq([test_definition]))
    end
  end

  describe(".delete_by_word_id") do
    it("deletes all definitions associated with a particular word") do
      test_definition = Definition.new({:definition => "Quick; Agile", :word_id => 1})
      test_definition.save()
      Definition.delete_by_word_id(1)
      expect(Definition.all()).to(eq([]))
    end
  end

  describe(".upvote") do
    it("adds a vote to a definition") do
      test_definition = Definition.new({:definition => "Quick; Agile", :word_id => 1})
      test_definition.save()
      Definition.upvote(1)
      expect(test_definition.votes()).to(eq(1))
    end
  end

  describe(".downvote") do
    it("removes a vote to a definition") do
      test_definition = Definition.new({:definition => "Quick; Agile", :word_id => 1})
      test_definition.save()
      Definition.downvote(1)
      expect(test_definition.votes()).to(eq(-1))
    end
  end
end
