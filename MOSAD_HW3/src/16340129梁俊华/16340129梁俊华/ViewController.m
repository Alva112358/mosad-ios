//
//  ViewController.m
//  16340129梁俊华
//
//  Created by 梁俊华 on 2019/9/25.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#define COLLECTION_CELL_IDENTIFIER @"cellid"

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "LanguageListController.h"
#import "MyTabBarController.h"
#import "Masonry.h"



@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate> {
    UILabel * _label;
    UICollectionView * _collections;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    self.dataSource = @[@{@"Image":[UIImage imageNamed:@"English.png"], @"Name":@"英语"},
                        @{@"Image":[UIImage imageNamed:@"German.png"], @"Name":@"德语"},
                        @{@"Image":[UIImage imageNamed:@"Japanese.png"], @"Name":@"日语"},
                        @{@"Image":[UIImage imageNamed:@"Spanish.png"], @"Name":@"西班牙语"}];
    [super viewDidLoad];
    [self setup];
    // [self setTitle:@"个人档案1"];
}

- (void)setup {
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置UILabel.
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    // _label.backgroundColor = UIColor.blackColor;
    [_label setText:@"请选择语言"];                      // 设置UILabel的文字内容.
    [_label setFont:[UIFont systemFontOfSize:25]];     // 设置UILabel的文字大小.
    [_label setTextColor:[UIColor blackColor]];        // 设置UILabel的颜色.
    [_label setTextAlignment:NSTextAlignmentCenter];   // 设置UILabel的文字的对齐方式.
    [self.view addSubview:_label];
    
    // 设置Collection.
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(150, 150);
    _collections = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 300, 300) collectionViewLayout:layout];
    [_collections registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER];
    _collections.backgroundColor = [UIColor whiteColor];
    _collections.delegate = self;
    _collections.dataSource = self;
    [self.view addSubview:_collections];
    
    // 设置首页文字的位置
    UIView * superview = self.view;
    [_label makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.top).offset(200);
        make.centerX.equalTo(superview.centerX);
    }];

    _collections.center = superview.center;
}

- (void)gotoTabBarListWith:(NSString *)language {
    MyTabBarController * tbc = [[MyTabBarController alloc] init];
    // self.hidesBottomBarWhenPushed = YES;
    tbc.name = language;
    [self.navigationController pushViewController:tbc animated:YES];
    // [self presentViewController:tbc animated:YES completion:nil];
    // NSArray * array = [self.navigationController viewControllers];
    // NSLog(@"%ld", [array count]);
}

#pragma mark UICollectionViewDataSource

// 返回section数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

// 每个section的item数
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 2;
}

// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MyCollectionViewCell * cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER forIndexPath:indexPath];
    NSLog(@"%@", _dataSource[2 * indexPath.section + indexPath.item][@"Name"]);
    UIImage * cellImage = _dataSource[2 * indexPath.section + indexPath.item][@"Image"];
    NSString * cellTex  = _dataSource[2 * indexPath.section + indexPath.item][@"Name"];
    
    [cell setCellWithImage:cellImage withText:cellTex];
    
    return cell;
}

// 设置每个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(_collections.frame.size.width / 2, _collections.frame.size.height / 2);
    return size;
}

// 设置两个cell之间的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
    
}

// 设置行内距离
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

// 设置点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"Row : %ld, Col : %ld", indexPath.section, indexPath.item);
    NSString * cellTex  = _dataSource[2 * indexPath.section + indexPath.item][@"Name"];
    [self gotoTabBarListWith:cellTex];
    
}

@end
