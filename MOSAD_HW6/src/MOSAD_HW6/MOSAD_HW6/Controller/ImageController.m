//
//  ImageController.m
//  MOSAD_HW6
//
//  Created by 梁俊华 on 2019/11/24.
//  Copyright © 2019 梁俊华. All rights reserved.
//
#define COLLECTION_CELL_IDENTIFIER @"reuseCell"
#import <Foundation/Foundation.h>
#import "ImageController.h"
#import "ImageCell.h"

@interface ImageController() <UICollectionViewDelegate, UICollectionViewDataSource> {
    NSMutableArray<NSURL *> * urlSet;
    UICollectionView * _collect;
}

@end

@implementation ImageController

- (void)viewDidLoad {
    NSURL * url1 = [NSURL URLWithString:@"https://hbimg.huabanimg.com/d8784bbeac692c01b36c0d4ff0e072027bb3209b106138-hwjOwX_fw658"];
    NSURL * url2 = [NSURL URLWithString:@"https://hbimg.huabanimg.com/6215ba6f9b4d53d567795be94a90289c0151ce73400a7-V2tZw8_fw658"];
    NSURL * url3 = [NSURL URLWithString:@"https://hbimg.huabanimg.com/834ccefee93d52a3a2694535d6aadc4bfba110cb55657-mDbhv8_fw658"];
    NSURL * url4 = [NSURL URLWithString:@"https://hbimg.huabanimg.com/f3085171af2a2993a446fe9c2339f6b2b89bc45f4e79d-LacPMl_fw658"];
    NSURL * url5 = [NSURL URLWithString:@"https://hbimg.huabanimg.com/e5c11e316e90656dd3164cb97de6f1840bdcc2671bdc4-vwCOou_fw658"];
    urlSet = [NSMutableArray arrayWithObjects: url1, url2, url3, url4, url5, nil];
    self.dataSource = [NSMutableArray arrayWithCapacity:5];
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    // Collection
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;//UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(self.view.frame.size.width - 10, 170);
    _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, 2000) collectionViewLayout:layout];
    [_collect registerClass:[ImageCell class] forCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER];
    _collect.backgroundColor = UIColor.whiteColor;
    // _collect.alwaysBounceVertical = YES;
    _collect.dataSource = self;
    _collect.delegate = self;
    _collect.alwaysBounceVertical = YES;
    [self.view addSubview:_collect];
}

// Process for button.
- (void)download {
    [self downloadImage];
}

// Process for clean the image.
- (void)clean {
    [self.dataSource removeAllObjects];
    [_collect reloadData];
}

// Process for delete the cache.
- (void)deleteCache {
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray * files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];

    for (NSString * p in files) {
        NSError * error = nil;
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent:p];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileAbsolutePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:fileAbsolutePath error:&error];
        }
    }
}

- (void)downloadImage {
    NSMutableArray<NSData *> * imageSet = [NSMutableArray arrayWithCapacity:6];
    
    // If the cache is not empty, then read data from cache directly.
    if ([self isCacheExist]) {
        NSLog(@"Cache is not empty!");
        NSString * cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        
        for (int i = 0; i < [self->urlSet count]; i++) {
            NSString * filePath = [cacheDir stringByAppendingPathComponent:[@"image" stringByAppendingString:[NSString stringWithFormat:@"%d", i]]];
            NSData * data = [NSData dataWithContentsOfFile:filePath];
            imageSet[i] = data;
        }
        
        NSMutableArray<UIImage *> * newImageSet = [NSMutableArray arrayWithCapacity:5];
        for (int i = 0; i < [self->urlSet count]; i++) {
            newImageSet[i] = [UIImage imageWithData:imageSet[i]];
        }
        
        for (int i = 0; i < [self->urlSet count]; i++) {
            self.dataSource[i] = newImageSet[i];
        }
        
        NSLog(@"%ld", [self.dataSource count]);
        [self->_collect reloadData];
    }
    
    // Else load data from network throught multithread.
    else {
        NSLog(@"Cache is empty!");
        [self clean];
        
        // Get the main queue.
        // dispatch_queue_t mainQueue = dispatch_get_main_queue();
        for (int i = 0; i < 5; i++) {
            self.dataSource[i] = [UIImage imageNamed:@"loading.png"];
        }
        [self->_collect reloadData];
        
        
        // Create a new queue and use it download images.
        dispatch_queue_t downloadQueue = dispatch_queue_create("download.images", NULL);
        for (int i = 0; i < [self->urlSet count]; i++) {
            dispatch_async(downloadQueue, ^{
                // Write data into the cache.
                NSString * cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
                imageSet[i] = [NSData dataWithContentsOfURL:self->urlSet[i]];
                NSString * filePath = [cacheDir stringByAppendingPathComponent:[@"image" stringByAppendingString:[NSString stringWithFormat:@"%d", i]]];
                [imageSet[i] writeToFile:filePath atomically:YES];
                
                // Return to the main queue: display images.
                dispatch_async(dispatch_get_main_queue(), ^{
                    // [NSThread sleepForTimeInterval:0.5];
                    self.dataSource[i] = [UIImage imageWithData:imageSet[i]];
                    [self->_collect reloadData];
                });
            });
        }
    }
    

}

- (BOOL)isCacheExist {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * path = [paths objectAtIndex:0];
    NSString * filePath = [path stringByAppendingPathComponent:@"image0"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
}

#pragma mark UICollectionViewDataSource
// 返回section数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dataSource count];
}

// 返回每个section的item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ImageCell * cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER forIndexPath:indexPath];
    
    [cell setWithImage:self.dataSource[indexPath.section]];
    return cell;
}

// 设置cell的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // UIEdgeInsets insets = {top, left, bottom, right};
    return UIEdgeInsetsMake(10, 25, 10, 25);
}

@end
