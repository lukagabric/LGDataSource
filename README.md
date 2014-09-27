LGDataSource
============

iOS data fetch and serialization

Installation
------------

Use Cocoapods.

Sample usage:
------------

    self.dataSource = [[LGDataSource alloc] initWithSession:[self session]
                                                 url:@"http://scripting.com/rss.json"
                                                  andParser:[NewsJSONParser new]];
                                                  
    [_newsDataSource fetchObjectsWithCompletionBlock:^(NSURLResponse *response, NSArray *parsedItems, NSError *error) {
        //handle error or use parsedItems
    }];

Parser needs to conform to LGParserInterface.

See sample app for more details.
