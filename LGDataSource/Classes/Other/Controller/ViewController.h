//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "LGDataSource.h"


@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak UITableView *_tableView;

    LGDataSource *_newsDataSource;
    NSArray *_newsItems;    
}


@end
