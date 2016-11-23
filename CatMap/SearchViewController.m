//
//  SearchViewController.m
//  CatMap
//
//  Created by Victor Hong on 22/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "SearchViewController.h"
#import "NetworkQuery.h"
#import "NetworkRequest.h"
@import CoreLocation;

@interface SearchViewController () <CLLocationManagerDelegate, DataProtocol>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UISwitch *getUserLocationSwitch;
@property (strong, nonatomic) CLLocationManager* manager;
@property NetworkRequest *networkRequest;

@property BOOL getUserLocation;
@property NSString *latitude;
@property NSString *longitude;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.manager = [CLLocationManager new];
    self.getUserLocation = YES;
    
    self.manager.delegate = self;
    [self.manager requestAlwaysAuthorization];
    //[self.manager startUpdatingLocation];
    
    self.networkRequest = [[NetworkRequest alloc] init];
    self.networkRequest.photoDelegate = self;
    
}

- (IBAction)saveSearch:(UIBarButtonItem *)sender {
    
    [self.manager requestLocation];
    
    if (self.getUserLocationSwitch.on) {
        
        self.getUserLocation = YES;
        
    } else {
        
        self.getUserLocation = NO;

    }
    
}

#pragma mark - CLLocation Manager Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = [locations lastObject];
    
    self.latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    NSLog(@"%@", self.latitude);
    NSLog(@"%@", self.longitude);
    
    [self.networkRequest getPhotos:self.searchTextField.text];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"error: %@", error);
    
}

-(void)gotData:(NSMutableArray<PhotoModel *> *)photoModelArray {
    
    
    
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
