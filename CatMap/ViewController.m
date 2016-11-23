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
#import "NetworkRequest.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, DataProtocol>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <PhotoModel *>*photoArray;
@property NetworkRequest *networkRequest;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.photoArray = [[NSMutableArray alloc] init];
    
    self.networkRequest = [[NetworkRequest alloc] init];
    
    self.networkRequest.photoDelegate = self;

    [self.networkRequest getPhotos:@"cat"];
    
}

-(void)gotData:(NSMutableArray<PhotoModel *> *)photoModelArray {
    
    self.photoArray = photoModelArray;
    
    for (PhotoModel *photo in self.photoArray) {
        [photo getLocationCoordinate];
    }
    
    [self.collectionView reloadData];
    
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
