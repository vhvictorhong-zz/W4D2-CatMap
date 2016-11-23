//
//  NetworkQuery.m
//  CatMap
//
//  Created by Victor Hong on 22/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "NetworkQuery.h"

@implementation NetworkQuery

static NSString * const scheme = @"https";
static NSString * const host = @"api.flickr.com";
static NSString * const path = @"/services/rest/";

static NSString * const apiKeyKey = @"api_key";
static NSString * const apiKeyValue = @"8378e436b57070a4e9900a64d8fa6562";

static NSString * const formatKey = @"format";
static NSString * const formatValue = @"json";

static NSString * const noJSONCallBackKey = @"nojsoncallback";
static NSString * const noJSONCallBackValue = @"1";

static NSString * const perPageKey = @"per_page";
static NSString * const perPageValue = @"50";

static NSString * const methodKey = @"method";
static NSString * const methodValueSearch = @"flickr.photos.search";
static NSString * const methodValueGetLocation = @"flickr.photos.geo.getLocation";

static NSString * const hasGeoKey = @"has_geo";
static NSString * const hasGeoValue = @"1";

static NSString * const extrasKey = @"extras";
static NSString * const extrasValue = @"url_m";

static NSString * const photoIDKey = @"photo_id";

static NSString * const latKey = @"lat";
static NSString * const lonKey = @"lon";

static NSString * const tagKey = @"tags";

+(NSURLComponents *)createURLSearch:(NSString *)searchKey{
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = scheme;
    components.host = host;
    components.path = path;
    
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:apiKeyKey value:apiKeyValue];
    NSURLQueryItem *formatItem = [NSURLQueryItem queryItemWithName:formatKey value:formatValue];
    NSURLQueryItem *noJSONCallBackItem = [NSURLQueryItem queryItemWithName:noJSONCallBackKey value:noJSONCallBackValue];
    NSURLQueryItem *perPageItem = [NSURLQueryItem queryItemWithName:perPageKey value:perPageValue];
    NSURLQueryItem *methodItem = [NSURLQueryItem queryItemWithName:methodKey value:methodValueSearch];
    NSURLQueryItem *hasGeoItem = [NSURLQueryItem queryItemWithName:hasGeoKey value:hasGeoValue];
    NSURLQueryItem *extraItem = [NSURLQueryItem queryItemWithName:extrasKey value:extrasValue];
    NSURLQueryItem *tagItem = [NSURLQueryItem queryItemWithName:tagKey value:searchKey];
    
    components.queryItems = @[apiKeyItem, formatItem, noJSONCallBackItem, perPageItem, methodItem, hasGeoItem, extraItem, tagItem];

    return components;
    
}

+(NSURLComponents *)createURLSearchWithCoordinate:(NSString *)searchKey latitude:(NSString *)latitude longitude:(NSString *)longitude {
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = scheme;
    components.host = host;
    components.path = path;
    
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:apiKeyKey value:apiKeyValue];
    NSURLQueryItem *formatItem = [NSURLQueryItem queryItemWithName:formatKey value:formatValue];
    NSURLQueryItem *noJSONCallBackItem = [NSURLQueryItem queryItemWithName:noJSONCallBackKey value:noJSONCallBackValue];
    NSURLQueryItem *perPageItem = [NSURLQueryItem queryItemWithName:perPageKey value:perPageValue];
    NSURLQueryItem *methodItem = [NSURLQueryItem queryItemWithName:methodKey value:methodValueSearch];
    NSURLQueryItem *hasGeoItem = [NSURLQueryItem queryItemWithName:hasGeoKey value:hasGeoValue];
    NSURLQueryItem *extraItem = [NSURLQueryItem queryItemWithName:extrasKey value:extrasValue];
    NSURLQueryItem *tagItem = [NSURLQueryItem queryItemWithName:tagKey value:searchKey];
    
    NSURLQueryItem *latitudeItem = [NSURLQueryItem queryItemWithName:latKey value:latitude];
    NSURLQueryItem *longitudeItem = [NSURLQueryItem queryItemWithName:lonKey value:longitude];
    
    components.queryItems = @[apiKeyItem, formatItem, noJSONCallBackItem, perPageItem, methodItem, hasGeoItem, extraItem, tagItem, latitudeItem, longitudeItem];
    
    return components;
    
}

+(NSURLComponents *)createURLGetLocation:(NSString *)photoID {
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = scheme;
    components.host = host;
    components.path = path;
    
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:apiKeyKey value:apiKeyValue];
    NSURLQueryItem *formatItem = [NSURLQueryItem queryItemWithName:formatKey value:formatValue];
    NSURLQueryItem *noJSONCallBackItem = [NSURLQueryItem queryItemWithName:noJSONCallBackKey value:noJSONCallBackValue];
    NSURLQueryItem *methodItem = [NSURLQueryItem queryItemWithName:methodKey value:methodValueGetLocation];
    NSURLQueryItem *photoIDItem = [NSURLQueryItem queryItemWithName:photoIDKey value:photoID];
    
    components.queryItems = @[apiKeyItem, formatItem, noJSONCallBackItem, methodItem, photoIDItem];
    
    return components;
    
}

@end
