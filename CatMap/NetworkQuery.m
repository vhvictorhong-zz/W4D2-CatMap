//
//  NetworkQuery.m
//  CatMap
//
//  Created by Victor Hong on 22/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "NetworkQuery.h"

@implementation NetworkQuery

+(NSURLComponents *)createURLComponents:(NSMutableArray *)queryItems {
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = @"api.flickr.com";
    components.path = @"/services/rest/";
    
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:@"8378e436b57070a4e9900a64d8fa6562"];
    NSURLQueryItem *formatItem = [NSURLQueryItem queryItemWithName:@"format" value:@"json"];
    NSURLQueryItem *noJSONCallBackItem = [NSURLQueryItem queryItemWithName:@"nojsoncallback" value:@"1"];
    NSURLQueryItem *perPageItem = [NSURLQueryItem queryItemWithName:@"per_page" value:@"50"];
    
    NSMutableArray *queryItemsMutableArray = [NSMutableArray arrayWithObjects:apiKeyItem, formatItem, noJSONCallBackItem, perPageItem, nil];
    [queryItemsMutableArray addObjectsFromArray:queryItems];
    NSArray *queryItemsArray = [queryItemsMutableArray copy];
    
    components.queryItems = queryItemsArray;

    return components;
    
}

@end
