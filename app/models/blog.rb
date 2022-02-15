require 'elasticsearch/model'

class Blog < ApplicationRecord
  belongs_to :user

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include BlogElasticSearchConcern

  after_save :update_blog_el_index

  validates :title, presence: true,
            length: { minimum: 5 }

  def preview
    if body.length <= 25
      # Return if the body is already sufficiently short
      body
    else
      # Ensure length will be <= 25 even after '...' is appended
      truncated = body[0..22]

      # Remove characters until a space is found (so we don't break a word)
      while truncated[truncated.length - 1] != ' ' && truncated.length > 0
        truncated = truncated[0..truncated.length - 2]
      end

      # Remove the space
      truncated = truncated[0..truncated.length - 2] if truncated[truncated.length - 1] == ' '

      # Append '...' and return
      truncated + '...'
    end
  end

end
