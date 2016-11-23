//
//  PhotoModel.m
//  CatMap
//
//  Created by Victor Hong on 22/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "PhotoModel.h"
#import "NetworkQuery.h"

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
    
    LocationManager *locationManager = [[LocationManager alloc] init];
    locationManager.locationDelegate = self;
    
    [locationManager getLocation:self.photoID];
    
}

-(void)gotLocation:(double)latitude longitude:(double)longitude {
    
    _coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
}

@end
