//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


#import "LGDataSource.h"


@interface DataSourceFactory : NSObject


+ (LGDataSource *)newsJSONDataSource;
+ (LGDataSource *)newsXMLDataSource;
+ (LGDataSource *)newsDataSourceWithActivityView:(UIView *)activityView;


@end