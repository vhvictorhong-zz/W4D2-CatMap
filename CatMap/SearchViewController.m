//
//  SearchViewController.m
//  CatMap
//
//  Created by Victor Hong on 22/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "SearchViewController.h"
#import "NetworkQuery.h"
@import CoreLocation;

@interface SearchViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UISwitch *getUserLocationSwitch;
@property (strong, nonatomic) CLLocationManager* manager;

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
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    
    if (self.getUserLocation) {
        
        components = [NetworkQuery createURLSearchWithCoordinate:self.searchTextField.text latitude:self.latitude longitude:self.longitude];

    } else {
        
        components = [NetworkQuery createURLSearch:self.searchTextField.text];
        
    }
    
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
            
            //            NSLog(@"title: %@", title);
            //            NSLog(@"photoID: %@", photoID);
            //            NSLog(@"url_m: %@", url_m);
            
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //This will run on the main queue
            
            //            for (PhotoModel *photo in self.photoArray) {
            //                [photo getLocationCoordinate];
            //            }
            //
            //            [self.collectionView reloadData];
            
        }];
        
        
    }];
    
    [dataTask resume];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"error: %@", error);
    
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
