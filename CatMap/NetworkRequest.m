//
//  NetworkRequest.m
//  CatMap
//
//  Created by Victor Hong on 23/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "NetworkRequest.h"
#import "NetworkQuery.h"

@implementation NetworkRequest

-(void)getPhotos:(NSString *)search {
    
    NSMutableArray *photoArray = [[NSMutableArray alloc] init];
    NSURLComponents *components = [NetworkQuery createURLSearch:search];
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:components.URL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            //Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSMutableDictionary *photoSearch = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            
            //Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        NSDictionary *photosDictionary = photoSearch[@"photos"];
        
        //If we reach this point, we have successfully retrieved the JSON from the API
        for (NSDictionary *photo in photosDictionary[@"photo"]) {
            
            NSString *title = photo[@"title"];
            NSString *photoID = photo[@"id"];
            NSString *url_m = photo[@"url_m"];
            
            [photoArray addObject:[[PhotoModel alloc] initWithTitle:title photoID:photoID url:url_m]];
            //            NSLog(@"title: %@", title);
            //            NSLog(@"photoID: %@", photoID);
            //            NSLog(@"url_m: %@", url_m);
            
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //This will run on the main queue
            [self.photoDelegate gotData:photoArray];
            
        }];
        
        
    }];
    
    [dataTask resume];
    
}

@end
