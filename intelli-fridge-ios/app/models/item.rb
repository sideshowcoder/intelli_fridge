class Item < CBLModelBase
  attribute :barcode, :available

  def self.docType
    "item"
  end

  def self.queryItemsInDatabase database
    view = database.viewNamed("items")
    Blocks.setupItemsMapBlockForView(view)
    view.createQuery
  end
end

