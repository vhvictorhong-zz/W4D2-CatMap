//
//  DetailViewController.m
//  CatMap
//
//  Created by Victor Hong on 22/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "DetailViewController.h"
#import "BasicAnnotation.h"
@import MapKit;

@interface DetailViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.photoModel.title;
    MKCoordinateSpan span = MKCoordinateSpanMake(.5f, .5f);
    self.mapView.region = MKCoordinateRegionMake(self.photoModel.coordinate, span);
    
    BasicAnnotation *annotation = [[BasicAnnotation alloc] init];
    annotation.title = self.photoModel.title;
    annotation.coordinate = self.photoModel.coordinate;
    annotation.image = self.photoModel.image;
    
    [self.mapView addAnnotation:annotation];
    
}

-(MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[BasicAnnotation class]]) {
        
        BasicAnnotation* basicAnnotation = (BasicAnnotation*) annotation;
        MKAnnotationView* view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"annotation"];
        
        if (!view) {
            view = [basicAnnotation createAnnotationView];
        }
        else {
            view.annotation = annotation;
        }
        
        return view;
        
    } else {
        
        return nil;
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
