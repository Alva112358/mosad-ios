//
//  CustomController.m
//  MOSAD_HW6
//
//  Created by 梁俊华 on 2019/11/24.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomCollection.h"
#import "ImageCell.h"

@interface CustomCollection()

@end

@implementation CustomCollection

static NSString * const reuseIdentifier = @"CollectionViewCell";

-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(103, 103);
    // 设置最小行间距
    layout.minimumLineSpacing = 20;
    // 设置垂直间距
    layout.minimumInteritemSpacing = 0;
    // 设置边缘的间距，默认是{0，0，0，0}
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.title = @"基础Cell";
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCollection class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setWithImage:[UIImage imageNamed:@"loading.png"]];
    return cell;
}

@end
