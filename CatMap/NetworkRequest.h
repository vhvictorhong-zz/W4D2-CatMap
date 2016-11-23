//
//  NetworkRequest.h
//  CatMap
//
//  Created by Victor Hong on 23/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoModel.h"

@protocol DataProtocol <NSObject>

-(void)gotData:(NSMutableArray <PhotoModel *>*)photoModelArray;

@end

@interface NetworkRequest : NSObject

@property(nonatomic, weak) id<DataProtocol> photoDelegate;


-(void)getPhotos:(NSString *)search;

@end
