class Word < ActiveRecord::Base
  has_many :definitions, dependent: :destroy

  define_method(:error_check) do
    if name()[/[a-zA-Z]+/] != name()
      @error_message = "You can only use letters to add a word (no spaces or special characters)"
      return 1
    end
    0
  end
end
