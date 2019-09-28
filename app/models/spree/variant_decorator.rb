Spree::Variant.class_eval do
  has_many :bookkeeping_documents, as: :printable, dependent: :destroy
  has_one :tag, -> { where(template: 'product_tag') },
            class_name: 'Spree::BookkeepingDocument',
            as: :printable

  after_create :create_tag_document

  def create_tag_document
    bookkeeping_documents.create(template: 'product_tag')
  end
end