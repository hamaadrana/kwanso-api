module BlogElasticSearchConcern

  extend ActiveSupport::Concern
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks


  settings do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: :english
    end
  end

  def as_indexed_json(*)
    {
        id: id,
        title: title
    }
  end

  def update_blog_el_index
    __elasticsearch__.index_document
  end
end
