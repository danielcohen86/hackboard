# A Post is a model that represents a link someone posted on their hackboard. Posts
# are a *subclass* of ActiveRecord::Base, which provides functionality like validations,
# associations, and querying.
class Post < ActiveRecord::Base

  # attr_accessible is necessary to secure our models. When an attribute is present in
  # this list, you will be able to use it in a hash when creating or updating a model
  # - i.e. `Post.new(description: 'Test', link: 'http://www.test.com')`, or
  # `post.update_attributes(description: 'New desc')`
  #
  # You can still use attributes not in attr_accessible when directly accessing attributes - i.e.
  # `post.some_other_variable = 3`. Generally, you should *not* include any variables that drive
  # associations (`comment_id`, etc.) in your attr_accessible.
  attr_accessible :description, :link

  # The `presence` validator validates that a field is not blank.
  validates :description, presence: true

  # The `format` validator validates that a field matches a regular expression. In this case, we're
  # ensuring that a field looks like a link.
  validates :link, presence: true,
                   format: /^http:\/\/.+\.com$/

  validates :user, presence: true

  # Posts have many comments. In order for this association to work, the `comments` table should have
  # a `post_id` column.
  has_many :comments
  belongs_to :user
end
