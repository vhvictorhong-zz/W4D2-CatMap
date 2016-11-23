//
//  ViewController.m
//  CatMap
//
//  Created by Victor Hong on 22/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#import "DetailViewController.h"
#import "PhotoModel.h"
#import "NetworkQuery.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <PhotoModel *>*photoArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.photoArray = [[NSMutableArray alloc] init];
    
    NSURLQueryItem *methodItem = [NSURLQueryItem queryItemWithName:@"method" value:@"flickr.photos.search"];
    NSURLQueryItem *hasGeoItem = [NSURLQueryItem queryItemWithName:@"has_geo" value:@"1"];
    NSURLQueryItem *extraItem = [NSURLQueryItem queryItemWithName:@"extras" value:@"url_m"];
    NSURLQueryItem *tagItem = [NSURLQueryItem queryItemWithName:@"tags" value:@"cat"];
    
    NSMutableArray *queryMutableArray = [NSMutableArray arrayWithObjects:methodItem, hasGeoItem, extraItem, tagItem, nil];
    
    NSURLComponents *components = [NetworkQuery createURLComponents:queryMutableArray];
    
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
            
            [self.photoArray addObject:[[PhotoModel alloc] initWithTitle:title photoID:photoID url:url_m]];
//            NSLog(@"title: %@", title);
//            NSLog(@"photoID: %@", photoID);
//            NSLog(@"url_m: %@", url_m);
            
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //This will run on the main queue
            
            for (PhotoModel *photo in self.photoArray) {
                [photo getLocationCoordinate];
            }
            
            [self.collectionView reloadData];
            
        }];
        
        
    }];
    
    [dataTask resume];

}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.collectionView reloadData];
    
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.photoArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //Configure cell
//    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
//    effectView.frame = self.view.frame;
//    [cell.imageView addSubview:effectView];
    PhotoModel *photoModel = self.photoArray[indexPath.row];
    [photoModel convertURLToImage];
    cell.imageView.image = photoModel.image;
    cell.titleLabel.text = photoModel.title;
    
    return cell;
    
}

#pragma mark - PrepareSegue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"DetailVCSegue"]) {
        
        DetailViewController *dvc = segue.destinationViewController;
        UICollectionViewCell *cell = (UICollectionViewCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        dvc.photoModel = self.photoArray[indexPath.item];
        
    }
    
}

@end
