//
//  SearchViewController.m
//  CatMap
//
//  Created by Victor Hong on 22/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "SearchViewController.h"
@import CoreLocation;

@interface SearchViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UISwitch *getUserLocationSwitch;
@property (strong, nonatomic) CLLocationManager* manager;

@property NSString *latitude;
@property NSString *longitude;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.manager.delegate = self;
    [self.manager requestAlwaysAuthorization];
    
}

- (IBAction)saveSearch:(UIBarButtonItem *)sender {
    
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    
    if (self.getUserLocationSwitch.on) {
        
        [self.manager requestLocation];
        
        components.scheme = @"https";
        components.host = @"api.flickr.com";
        components.path = @"/services/rest/";
        NSURLQueryItem *methodItem = [NSURLQueryItem queryItemWithName:@"method" value:@"flickr.photos.search"];
        NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:@"8378e436b57070a4e9900a64d8fa6562"];
        NSURLQueryItem *hasGeoItem = [NSURLQueryItem queryItemWithName:@"has_geo" value:@"1"];
        NSURLQueryItem *extraItem = [NSURLQueryItem queryItemWithName:@"extras" value:@"url_m"];
        NSURLQueryItem *formatItem = [NSURLQueryItem queryItemWithName:@"format" value:@"json"];
        NSURLQueryItem *noJSONCallBackItem = [NSURLQueryItem queryItemWithName:@"nojsoncallback" value:@"1"];
        NSURLQueryItem *perPageItem = [NSURLQueryItem queryItemWithName:@"per_page" value:@"50"];
        NSURLQueryItem *tagItem = [NSURLQueryItem queryItemWithName:@"tags" value:self.searchTextField.text];
        NSURLQueryItem *latitudeItem = [NSURLQueryItem queryItemWithName:@"lat" value:self.latitude];
        NSURLQueryItem *longitudeItem = [NSURLQueryItem queryItemWithName:@"lon" value:self.longitude];
        
        components.queryItems = @[methodItem, apiKeyItem, hasGeoItem, extraItem, formatItem, noJSONCallBackItem, perPageItem, tagItem, latitudeItem, longitudeItem];
        
    } else {
        
        components.scheme = @"https";
        components.host = @"api.flickr.com";
        components.path = @"/services/rest/";
        NSURLQueryItem *methodItem = [NSURLQueryItem queryItemWithName:@"method" value:@"flickr.photos.search"];
        NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:@"8378e436b57070a4e9900a64d8fa6562"];
        NSURLQueryItem *hasGeoItem = [NSURLQueryItem queryItemWithName:@"has_geo" value:@"1"];
        NSURLQueryItem *extraItem = [NSURLQueryItem queryItemWithName:@"extras" value:@"url_m"];
        NSURLQueryItem *formatItem = [NSURLQueryItem queryItemWithName:@"format" value:@"json"];
        NSURLQueryItem *noJSONCallBackItem = [NSURLQueryItem queryItemWithName:@"nojsoncallback" value:@"1"];
        NSURLQueryItem *perPageItem = [NSURLQueryItem queryItemWithName:@"per_page" value:@"50"];
        NSURLQueryItem *tagItem = [NSURLQueryItem queryItemWithName:@"tags" value:self.searchTextField.text];
        components.queryItems = @[methodItem, apiKeyItem, hasGeoItem, extraItem, formatItem, noJSONCallBackItem, perPageItem, tagItem];
        
    }
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:components.URL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            //Handler the error
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
            
//            [self.photoArray addObject:[[PhotoModel alloc] initWithTitle:title photoID:photoID url:url_m]];
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

#pragma mark - CLLocation Manager Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = [locations lastObject];
    
    self.latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    
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
