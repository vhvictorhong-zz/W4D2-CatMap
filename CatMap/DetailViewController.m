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

@interface DetailViewController ()
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
    
    [self.mapView addAnnotation:annotation];
    
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
