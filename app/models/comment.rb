# Comments represent comments on posts. They only exist in the context of a particular post.
class Comment < ActiveRecord::Base
  # Note that post_id is *not* accessible here. We don't want to allow users to switch
  # what post a comment is on.
  attr_accessible :body

  # Validate that a post exists. Note that we validate the association name rather than
  # `post_id`. This has the benefit of Rails checking whether the post *actually* exists,
  # so ids that don't exist in the system will not pass this validator.
  validates :post, presence: true
  validates :user, presence: true

  # Comments belong to posts. This means there is one and only one post associated with a
  # comment (this could be nil, so we also added a validator). In order for this to work,
  # a column named `post_id` needs to exist on the `comments` table.
  belongs_to :post
  belongs_to :user
end
