//
//  LocationManager.m
//  CatMap
//
//  Created by Victor Hong on 23/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

-(void)getLocation:(NSString *)photoID {
    
    NSURLComponents *components = [NetworkQuery createURLGetLocation:photoID];
    
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
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //This will run on the main queue
            
            [self.locationDelegate gotLocation:latitude longitude:longitude];
            
        }];
        
        
    }];
    
    [dataTask resume];
    
}

@end
