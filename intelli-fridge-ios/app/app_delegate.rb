
class AppDelegate

  def application application, didFinishLaunchingWithOptions:launchOptions

    UIApplication.sharedApplication.setStatusBarHidden(true, animated:false)

    @items_view_controller = ItemsViewController.alloc.init
    @items_view_controller.database = database

    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
    @window.makeKeyAndVisible
    @window.rootViewController = @items_view_controller

    database.modelFactory.registerClass(Item.class, forDocumentType:"item")

    setup_sync

    query = database.createAllDocumentsQuery
    error_ptr = Pointer.new(:object)
    query.run(error_ptr).each do |i|
      p i.document
      p i.document.properties
    end

    true
  end

  def database
    return @database if @database

    manager = CBLManager.sharedInstance
    error_ptr = Pointer.new(:object)
    @database = manager.databaseNamed("items", error: error_ptr)
    unless @database
      error = error_ptr[0]
      alert = UIAlertView.alloc.initWithTitle("Local Database Error",
                                              message:"No access to local database. #{error}",
                                              delegate:nil,
                                              cancelButtonTitle:"Ok",
                                              otherButtonTitles: nil)
      alert.show
    else
      @database
    end
  end

  def setup_sync
    @sync_manager ||= SyncManager.new(database)
    @sync_manager.start_replication
  end
end
