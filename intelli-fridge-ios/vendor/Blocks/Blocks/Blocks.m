//
//  Blocks.m
//  Blocks
//
//  Created by Philipp Fehre on 13/05/14.
//  Copyright (c) 2014 couchbase. All rights reserved.
//

#import "Blocks.h"
#import <CouchbaseLite/CouchbaseLite.h>

@implementation Blocks

+(void)setupItemsMapBlockForView:(CBLView*)view
{
  if (!view.mapBlock) {
    [view setMapBlock: MAPBLOCK({
      if ([doc[@"type"] isEqualToString:@"item"])
        if ([doc[@"available"] isEqualToString:@"false"]) {
          emit(doc[@"barcode"], nil);
        }
    }) reduceBlock: nil version: @"3"];
  }
}
@end
