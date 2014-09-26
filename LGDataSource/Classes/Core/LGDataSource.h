//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LGParserInterface.h"


typedef void(^DataCompletionBlock)(NSData *data, NSURLResponse *response, NSError *error);
typedef void(^ObjectsCompletionBlock)(NSURLResponse *response, NSArray *parsedItems, NSError *error);


@interface LGDataSource : NSObject


@property (readonly, atomic) BOOL finished;
@property (readonly, atomic) BOOL running;
@property (readonly, atomic) BOOL cancelled;
@property (readonly, atomic) NSError *error;

@property (weak, nonatomic) UIView *activityView;

@property (readonly, nonatomic) NSURLSession *session;
@property (readonly, nonatomic) NSString *url;

@property (readonly, nonatomic) id <LGParserInterface> parser;

@property (readonly, nonatomic) NSArray *parsedItems;

@property (readonly, nonatomic) NSURLResponse *response;
@property (readonly, nonatomic) NSData *responseData;


- (instancetype)initWithSession:(NSURLSession *)session andUrl:(NSString *)url;
- (instancetype)initWithSession:(NSURLSession *)session url:(NSString *)url andParser:(id <LGParserInterface>)parser;


- (void)fetchDataWithCompletionBlock:(DataCompletionBlock)completionBlock;
- (void)fetchObjectsWithCompletionBlock:(ObjectsCompletionBlock)completionBlock;
- (void)cancelLoad;


#pragma mark -


@end


#pragma mark - Protected


@interface LGDataSource ()


@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSURLSessionDataTask *dataTask;
@property (strong, nonatomic) id <LGParserInterface> parser;
@property (strong, nonatomic) NSArray *parsedItems;
@property (strong, nonatomic) NSURLResponse *response;
@property (strong, nonatomic) NSData *responseData;
@property (copy, nonatomic) DataCompletionBlock dataCompletionBlock;
@property (copy, nonatomic) ObjectsCompletionBlock objectsCompletionBlock;


- (void)initialize;
- (void)parseData;
- (BOOL)isResponseValid;
- (void)showProgressForActivityView;
- (void)hideProgressForActivityView;


@end
