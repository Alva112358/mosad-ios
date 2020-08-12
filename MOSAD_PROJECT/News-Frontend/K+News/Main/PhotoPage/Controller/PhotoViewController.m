//
//  PhotoViewController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoViewController.h"
#import "ImageFlowCell.h"
#import "AFNetworking.h"

#import "GlobalVariable.h"

#define COLLECTION_CELL_IDENTIFIER @"reuseCell"
#define MAX_IMG 8

@interface PhotoViewController() <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation PhotoViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.dataSource = [NSMutableArray arrayWithCapacity:MAX_IMG];
    for (NSUInteger i = 0; i < MAX_IMG; i++) {
        self.dataSource[i] = [UIImage imageNamed:@"loading.png"];
    }
    [self setup];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    for (NSUInteger i = 0; i < MAX_IMG; i++) {
        self.dataSource[i] = [UIImage imageNamed:@"loading.png"];
    }
    [self.collection reloadData];
    [self downloadImageWithCount:MAX_IMG];
}

- (void)setup {
    /* Set collection */
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(197, 220);
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) collectionViewLayout:layout];
    [_collection registerClass:[ImageFlowCell class] forCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER];
    _collection.backgroundColor = UIColor.whiteColor;
    _collection.dataSource = self;
    _collection.delegate = self;
    [self.view addSubview:_collection];
    [self downloadImageWithCount:MAX_IMG];
    [self.collection reloadData];
}

// Down data from
- (void)downloadImageWithCount:(NSInteger)newsNum {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString * url = [BaseIP stringByAppendingString:@":8000/api/v1/photo/entries"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"count"] = [NSString stringWithFormat:@"%ld", newsNum];

    // Download
    [manager GET:url
      parameters:params
        progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // Create a new queue and use it to download images.
        // dispatch_semaphore_t sema = dispatch_semaphore_create(1);
        dispatch_queue_t dispatchQueue = dispatch_queue_create("download.images", DISPATCH_QUEUE_CONCURRENT);
        // dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
        dispatch_group_t dispatchGroup = dispatch_group_create();
        for (NSUInteger i = 0; i < [responseObject[@"count"] intValue]; i++) {
            dispatch_group_async(dispatchGroup, dispatchQueue, ^{
                NSString *imgUrl = responseObject[@"data"][i][@"image_link"];
                if (![imgUrl hasPrefix:@"http://"]) {
                    imgUrl = [NSString stringWithFormat:@"http://%@",imgUrl];
                }
                NSData * imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
                NSLog(@"Will download image link: %@", responseObject[@"data"][i][@"image_link"]);
                UIImage * img = [UIImage imageWithData:imgData];
                // Process the image.
                CGSize newSize = CGSizeMake(197, 220);
                UIGraphicsBeginImageContext(newSize);
                [img drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
                UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                self.dataSource[i] = newImage;
                // NSLog(@"Download finish %d!", i);
            });
        }
        // dispatch_semaphore_signal(sema);
        // dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
            [self.collection reloadData];
            //NSLog(@"Download finish!");
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Request fail, reasons = %@", error);
    }];
}


#pragma mark - UICollectionViewDataSource
// Number of sessions, given by 0.5 * dataSource.length.
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [_dataSource count] / 2;
}

// Column of each session = 2.
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

// Set the image of each cell.
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ImageFlowCell * cell = (ImageFlowCell *)[collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER forIndexPath:indexPath];
    [cell setWithImage:self.dataSource[indexPath.section * 2 + indexPath.item]];
    return cell;
}

@end
