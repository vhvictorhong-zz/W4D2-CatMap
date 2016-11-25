//
//  BasicAnnotation.m
//  CatMap
//
//  Created by Victor Hong on 22/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "BasicAnnotation.h"


@implementation BasicAnnotation

-(void) setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    
    _coordinate = newCoordinate;
    
}

-(MKAnnotationView*) createAnnotationView {
    
    MKAnnotationView* view = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"annotation"];
    view.enabled = YES;
    view.canShowCallout = YES;
    view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    view.image = self.image;
    
    return view;
    
}

@end
