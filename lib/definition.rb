class Definition < ActiveRecord::Base
  belongs_to :word

  def upvote
    new_vote = votes + 1
    update(votes: new_vote)
  end

  def downvote
    new_vote = votes()-1
    update(votes: new_vote)
  end
end
