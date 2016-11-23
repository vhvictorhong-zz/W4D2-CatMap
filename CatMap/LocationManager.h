//
//  LocationManager.h
//  CatMap
//
//  Created by Victor Hong on 23/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkQuery.h"

@protocol LocationDataProtocol <NSObject>

-(void)gotLocation:(double)latitude longitude:(double)longitude;

@end

@interface LocationManager : NSObject

@property(nonatomic, weak) id<LocationDataProtocol> locationDelegate;

-(void)getLocation:(NSString *)photoID;

@end
