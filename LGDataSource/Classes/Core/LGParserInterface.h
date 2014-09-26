//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


#import <Foundation/Foundation.h>


@protocol LGParserInterface <NSObject>


- (void)parseData:(id)data;
- (void)setResponse:(NSURLResponse *)response;
- (NSError *)error;
- (NSArray *)itemsArray;
- (void)abortParsing;


@end
