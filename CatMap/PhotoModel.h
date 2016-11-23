//
//  PhotoModel.h
//  CatMap
//
//  Created by Victor Hong on 22/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationManager.h"
@import MapKit;

@interface PhotoModel : NSObject <MKAnnotation, LocationDataProtocol>

@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, nonnull)NSString *photoID;
@property (nonatomic, nonnull)NSString *url;
@property (nonatomic, nonnull)UIImage *image;
//@property double latitude;
//@property double longitude;

@property(nonatomic) CLLocationCoordinate2D coordinate;

-(instancetype)initWithTitle:(NSString *)title photoID:(NSString *)photoID url:(NSString *)url;
-(void)convertURLToImage;
-(void)getLocationCoordinate;

@end
