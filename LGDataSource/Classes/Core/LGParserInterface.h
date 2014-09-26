#import <Foundation/Foundation.h>

@protocol LGParserInterface <NSObject>


- (void)parseData:(id)data;
- (void)setResponse:(NSURLResponse *)response;
- (NSError *)error;
- (NSArray *)itemsArray;
- (void)abortParsing;


@end