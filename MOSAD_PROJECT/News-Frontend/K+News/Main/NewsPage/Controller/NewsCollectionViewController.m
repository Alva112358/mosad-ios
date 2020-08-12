//
//  NewsCollectionViewController.m
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsCollectionViewController.h"

// 新闻页控件和数据
#import "../View/NewsCollectionViewCell.h"

// 新闻详情页
#import "NewsDetailViewController.h"


#import "Base/Extensions/UIColor+Hex.h"
#import "Base/GlobalVariable.h"
#import "Base/NetRequest.h"

#import "MJRefresh.h"

@interface NewsCollectionViewController()
<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    NewsCollectionViewCell * _cell;
}
@property (nonatomic, strong) NSMutableArray * newsBlock;
@property (nonatomic, strong) NSMutableArray * tempBlock;
@property (nonatomic, strong) NSMutableDictionary * imgDict;
@property (nonatomic, strong) NSOperationQueue * queue;
@end

@implementation NewsCollectionViewController

- (instancetype)init{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self){
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 0;
        
        self.collectionView.backgroundColor = UIColor.clearColor;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[NewsCollectionViewCell class] forCellWithReuseIdentifier:@"newsCollectionViewCell"];
    };
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithHexString: @"#F6F8FA"];
    
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshTempBlock];
        for (NSUInteger i=0; i<self.tempBlock.count; i++){
            [self.newsBlock insertObject:self.tempBlock[i] atIndex:0];
        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
        
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [self refreshTempBlock];
        for (NSUInteger i=0; i<self.tempBlock.count; i++){
            [self.newsBlock addObject:self.tempBlock[i]];
        }
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
}

- (NSMutableArray *)newsBlock{
    if (_newsBlock == nil){
        _newsBlock = [NSMutableArray array];
    }
    return _newsBlock;
}

- (NSMutableArray *)tempBlock{
    if (_tempBlock == nil){
        _tempBlock = [NSMutableArray array];
    }
    return _tempBlock;
}

- (void)refreshTempBlock{
    [self.tempBlock removeAllObjects];
    
    NSString * url = [BaseIP stringByAppendingFormat:@":8000/api/v1/news/%ld/entries", (long)self.tabID];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"count"] = @8;
    params[@"img_most"] = @10;
    
    [[NetRequest shareInstance] SynGET:url params:params progress:^(id downloadProgress) {
    } success:^(id responseObject) {
        NSArray * data = [responseObject objectForKey:@"data"];
        
        for (int i=0; i<data.count; i++){
            NewsModel * model = [[NewsModel alloc] initWithDict:data[i]];
            [self.tempBlock addObject:model];
        }
    } failues:^(id error) {
    }];
}

- (NSMutableDictionary *)imgDict{
    if (_imgDict == nil){
        _imgDict = [NSMutableDictionary dictionary];
    }
    return _imgDict;
}

- (NSOperationQueue *)queue{
    if (_queue == nil){
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (void)downloadImg:(NSString*)url{
    if (url == nil)return;
    NSLog(@"Will download image at url: %@", url);
    if (self.imgDict[url] != nil && self.imgDict[url] !=NSNull.null)return;
    
    self.imgDict[url] = NSNull.null;
    
    NSString * cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    __block NSString * cacheImgPath = [cacheDir stringByAppendingFormat:@"/%@", [[url lastPathComponent] stringByDeletingPathExtension]];
    __block UIImage * cacheImg = [UIImage imageWithContentsOfFile:cacheImgPath];
    if (cacheImg != nil){
        self.imgDict[url] = cacheImg;
        return;
    }
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        NSURL * nsurl = [NSURL URLWithString:url];
        NSData * data = [NSData dataWithContentsOfURL:nsurl];
        cacheImg = [UIImage imageWithData:data];
        
        if (cacheImg == nil){
            self.imgDict[url] = NSNull.null;
        }
        if (cacheImg != nil){
            [NSOperationQueue.mainQueue addOperationWithBlock:^{
                self.imgDict[url] = cacheImg;
                NSFileManager * fileManager = [NSFileManager defaultManager];
                [fileManager createFileAtPath:cacheImgPath contents:nil attributes:nil];
                [UIImagePNGRepresentation(cacheImg) writeToFile:cacheImgPath atomically:YES];

                [self.collectionView reloadData];
            }];
        }
    }];
    
    [self.queue addOperation:operation];
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.newsBlock.count;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    _cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newsCollectionViewCell" forIndexPath:indexPath];
    
    _cell.label.text = [self.newsBlock[indexPath.row] title];
    _cell.imageView.image = [UIImage imageNamed:@"loading"];
    
    for (int i=0; i<[self.newsBlock[indexPath.row] imageLinks].count; i++){
        [self downloadImg:[self.newsBlock[indexPath.row] imageLinks][i]];
    }
    
    UIImage * image = nil;
    for (int i=0; i<[self.newsBlock[indexPath.row] imageLinks].count; i++){
        image = self.imgDict[[self.newsBlock[indexPath.row] imageLinks][i]];
        if ([image isEqual:NSNull.null] == NO) break;
    }
    
    if (image != nil && [image isEqual:NSNull.null]==NO) _cell.imageView.image = image;
    else _cell.imageView.image = [UIImage imageNamed:@"no-images"];

    UILongPressGestureRecognizer* longpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpress:)];
    longpgr.minimumPressDuration = 1.0;
    longpgr.view.tag = indexPath.row;
    [_cell addGestureRecognizer:longpgr];
    
    return _cell;
}

- (void)longpress:(UILongPressGestureRecognizer*) longpgr{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"tips" message:@"确定删除吗" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            id obj = self.newsBlock[longpgr.view.tag];
            [self.newsBlock removeObject:obj];
            [self.collectionView reloadData];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width - 20, 200);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"Select collectionView item at indexPath: %@", indexPath);
    NewsDetailViewController * detailVC = [[NewsDetailViewController alloc] init];
    detailVC.detailUrl = [self.newsBlock[indexPath.row] detailUrl];
    detailVC.curNav = self.curNav;
    [self.curNav pushViewController:detailVC animated:YES];
}

@end
