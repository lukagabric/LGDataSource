//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


#import "LGDataSource.h"
#import "PromiseKit.h"


@interface LGDataSource (PromiseKit)


- (PMKPromise *)dataFetchPromise;
- (PMKPromise *)dataAndResponseFetchPromise;
- (PMKPromise *)objectsFetchPromise;
- (PMKPromise *)objectsAndResponseFetchPromise;


@end
