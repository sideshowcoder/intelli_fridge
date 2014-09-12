require "intelli_fridge_server/version"
require "database"


module IntelliFridgeServer
  class Fridge

    SYNC_URL = "http://localhost:4984/db"

    def initialize
      Database.establish_connection "items"
      Database.setup_sync "items", SYNC_URL
      @connection = Database.connection
    end

    def process_barcode barcode
      # TODO we should lookup the name on a remote service here...
      data = { "barcode" => barcode, "available" => "true", "type" => "item" }

      if doc = @connection.get_existing_document(barcode)
        availability = (doc.get_property("available") == "true")
        data["available"] = (!availability).to_s
        data["_rev"] = doc.current_revision.id
        puts "updating entry #{barcode}: available #{data["available"]}"
      else
        doc = @connection.get_document(barcode)
        puts "creating entry #{barcode}: available #{data["available"]}"
      end

      doc.put_properties data
    end
  end
end
