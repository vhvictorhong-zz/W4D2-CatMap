//
//  NetworkQuery.h
//  CatMap
//
//  Created by Victor Hong on 22/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkQuery : NSObject

+(NSURLComponents *)createURLSearch:(NSString *)searchKey;
+(NSURLComponents *)createURLSearchWithCoordinate:(NSString *)searchKey latitude:(NSString *)latitude longitude:(NSString *)longitude;
+(NSURLComponents *)createURLGetLocation:(NSString *)photoID;

@end
