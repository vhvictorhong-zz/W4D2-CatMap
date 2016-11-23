//
//  NetworkQuery.h
//  CatMap
//
//  Created by Victor Hong on 22/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkQuery : NSObject

+(NSURLComponents *)createURLComponents:(NSMutableArray *)queryItems;

@end
