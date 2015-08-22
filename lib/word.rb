class Word < ActiveRecord::Base
  define_method(:find_definitions) do
    Definition.find_by_word_id(id)
  end

  define_method(:error_check) do
    if word()[/[a-zA-Z]+/] != word()
      @error_message = "You can only use letters to add a word (no spaces or special characters)"
      return 1
    end
    0
  end
end
