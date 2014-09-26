//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


#import "LGDataSource+PromiseKit.h"


@implementation LGDataSource (PromiseKit)


- (PMKPromise *)dataFetchPromise
{
    PMKPromise *promise = [PMKPromise new:^(PMKPromiseFulfiller fulfill, PMKPromiseRejecter reject) {
        [self fetchDataWithCompletionBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error)
                reject(error);
            else
                fulfill(data);
        }];
    }];
    
    return promise;
}


- (PMKPromise *)dataAndResponseFetchPromise
{
    PMKPromise *promise = [PMKPromise new:^(PMKPromiseFulfiller fulfill, PMKPromiseRejecter reject) {
        [self fetchDataWithCompletionBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error)
                reject(error);
            else
                fulfill(@[data, response]);
        }];
    }];
    
    return promise;
}


- (PMKPromise *)objectsFetchPromise
{
    PMKPromise *promise = [PMKPromise new:^(PMKPromiseFulfiller fulfill, PMKPromiseRejecter reject) {
        [self fetchObjectsWithCompletionBlock:^(NSURLResponse *response, NSArray *parsedItems, NSError *error) {
            if (error)
                reject(error);
            else
                fulfill(parsedItems);
        }];
    }];
    
    return promise;
}


- (PMKPromise *)objectsAndResponseFetchPromise
{
    PMKPromise *promise = [PMKPromise new:^(PMKPromiseFulfiller fulfill, PMKPromiseRejecter reject) {
        [self fetchObjectsWithCompletionBlock:^(NSURLResponse *response, NSArray *parsedItems, NSError *error) {
            if (error)
                reject(error);
            else
                fulfill(@[parsedItems, response]);
        }];
    }];
    
    return promise;
}


@end
