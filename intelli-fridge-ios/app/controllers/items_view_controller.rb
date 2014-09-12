class ItemsViewController < UIViewController
  attr_accessor :database, :data_source

  def viewDidLoad
    super
    @items_table = UITableView.alloc.initWithFrame(view.bounds)
    @items_table.delegate = self
    @data_source = CBLUITableSource.alloc.init
    @data_source.query = Item.queryItemsInDatabase(database).asLiveQuery
    p @data_source.query
    @data_source.labelProperty = "barcode"
    @data_source.tableView = @items_table
    @items_table.dataSource = @data_source

    view.addSubview @items_table
  end

  def couchTableSource source, updateFromQuery:query, previousRows:previousRows
    @items_table.reloadData
  end

  def couchTableSource source, willUseCell:cell, forRow:row
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
  end

  def tableView tableView, didSelectRowAtIndexPath:indexPath; end
end
