//
//  PhotoModel.m
//  CatMap
//
//  Created by Victor Hong on 22/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

-(instancetype)initWithTitle:(NSString *)title photoID:(NSString *)photoID url:(NSString *)url {
    
    if (self = [super init]) {
        
        _title = title;
        _photoID = photoID;
        _url = url;
        
    }
    
    return self;
    
}

-(void)convertURLToImage {
    
    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.url]];
    _image = [UIImage imageWithData: data];
    
}

-(void)getLocationCoordinate {
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = @"api.flickr.com";
    components.path = @"/services/rest/";
    NSURLQueryItem *methodItem = [NSURLQueryItem queryItemWithName:@"method" value:@"flickr.photos.geo.getLocation"];
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:@"8378e436b57070a4e9900a64d8fa6562"];
    NSURLQueryItem *photoIDItem = [NSURLQueryItem queryItemWithName:@"photo_id" value:self.photoID];
    NSURLQueryItem *formatItem = [NSURLQueryItem queryItemWithName:@"format" value:@"json"];
    NSURLQueryItem *noJSONCallBack = [NSURLQueryItem queryItemWithName:@"nojsoncallback" value:@"1"];
    components.queryItems = @[methodItem, apiKeyItem, photoIDItem, formatItem, noJSONCallBack];
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:components.URL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            //Handler the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSMutableDictionary *photosDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            
            //Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        NSDictionary *photoDictionary = photosDictionary[@"photo"];
        NSDictionary *locationDictionary = photoDictionary[@"location"];
        
        //If we reach this point, we have successfully retrieved the JSON from the API
            
        double latitude = [locationDictionary[@"latitude"] doubleValue];
        double longitude = [locationDictionary[@"longitude"] doubleValue];
        
//        NSLog(@"latitude: %f", latitude);
//        NSLog(@"longitude: %f", longitude);
        
        _latitude = latitude;
        _longitude = longitude;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //This will run on the main queue
            _coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
//            NSLog(@"latitude: %f, longitude: %f", self.coordinate.latitude,self.coordinate.longitude);
            
        }];
        
        
    }];
    
    [dataTask resume];
}

@end
