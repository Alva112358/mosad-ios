//
//  VideoViewController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoViewController.h"
#import "AFNetworking.h"

#import "GlobalVariable.h"



#define COLLECTION_CELL_IDENTIFIER @"reuseCell"
#define MAX_VEDIO 10


@interface VideoViewController() <RHPlayerViewDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation VideoViewController

- (void)viewDidLoad {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [super viewDidLoad];
    // [self addSubViews];
    [self downloadVideoWithCount];
    // [self loadData];
    [self addSubViews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        [self.player stop];
    }
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [self.player playVideoWithVideoId:self.]
//}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player pause];
}

- (void)downloadVideoWithCount {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString * URL = [BaseIP stringByAppendingString:@":8000/api/v1/video/entries?"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"count"] = [NSString stringWithFormat:@"%d", MAX_VEDIO];
    // _dataSource = [NSMutableArray arrayWithCapacity:count];

    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    dispatch_queue_t downloadQueue = dispatch_queue_create("download.images", NULL);
    dispatch_async(downloadQueue, ^{
        
        [manager GET:URL
          parameters:params
            progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            for (NSUInteger i = 0; i < MAX_VEDIO; i++) {
                RHVideoModel * model = [[RHVideoModel alloc]
                        initWithVideoId:[NSString stringWithFormat:@"%03lu", i + 1]
                                  title:responseObject[@"data"][i][@"title"]
                                    url:responseObject[@"data"][i][@"video_link"] currentTime:0
                ];
                self.dataSource[i] = model;
                self.imgArr[i] = responseObject[@"data"][i][@"video_preview"];
                self.goodArr[i] = [NSString stringWithFormat:@"%@", responseObject[@"data"][i][@"n_good"]];
                self.commentArr[i] = [NSString stringWithFormat:@"%@", responseObject[@"data"][i][@"n_comment"]];
            }
            NSLog(@"Download Complete! Total video count = %ld", [self.dataSource count]);
            dispatch_semaphore_signal(sema);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Connect to website fail, error = %@", error);
            dispatch_semaphore_signal(sema);
        }];
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Finished, total video count = %ld", [self.dataSource count]);
            [self.player setVideoModels:self.dataSource playVideoId:@""];
            [self.tableView reloadData];
        });
    });
    
//    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    // NSLog(@"Finished, total video count = %ld", [self.dataSource count]);
    [self.player setVideoModels:self.dataSource playVideoId:@""];
    [self.tableView reloadData];
}

- (void)addSubViews {
    UIView * superview = self.view;
    [superview addSubview:_tableView];
    [superview addSubview:_player];
    [self setupLayout];
}

- (void)setupLayout {
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(9 * [[UIScreen mainScreen] bounds].size.width / 16));
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:COLLECTION_CELL_IDENTIFIER];
    VideoCell * cell = [tableView dequeueReusableCellWithIdentifier:COLLECTION_CELL_IDENTIFIER];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < [_dataSource count]) {
        
        RHVideoModel * model = _dataSource[indexPath.row];
        // cell.textLabel.text = model.title;
        [cell setupUIWithTitle:model.title WithImage:_imgArr[indexPath.row] WithGood:_goodArr[indexPath.row] WithComment:_commentArr[indexPath.row]
            WithVideo:model WithPlayer:self.player];
    }
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    RHVideoModel * model = _dataSource[indexPath.row];
//    [_player playVideoWithVideoId:model.videoId];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

#pragma mark - playerViewDelegate
- (BOOL)playerViewShouldPlay {
    return YES;
}

- (void)playerView:(RHPlayerView *)playView didPlayVideo:(RHVideoModel *)videoModel index:(NSInteger)index {
}

- (void)playerView:(RHPlayerView *)playView didPlayEndVideo:(RHVideoModel *)videoModel index:(NSInteger)index {
}

- (void)playerView:(RHPlayerView *)playView didPlayVideo:(RHVideoModel *)videoModel playTime:(NSTimeInterval)playTime {
}

#pragma mark - setterAndGetter
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UITableView * tableView = [[UITableView alloc] init];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[VideoCell class] forCellReuseIdentifier:COLLECTION_CELL_IDENTIFIER];
        tableView.tableFooterView = [[UIView alloc] init];
        _tableView = tableView;
    }
    return _tableView;
}

- (RHPlayerView *)player {
    if (!_player) {
        _player = [[RHPlayerView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 9 * [[UIScreen mainScreen] bounds].size.width / 16) currentVC:self];
        _player.delegate = self;
    }
    return _player;
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:MAX_VEDIO];
    }
    return _dataSource;
}

- (NSMutableArray *)imgArr {
    if (!_imgArr) {
        _imgArr = [NSMutableArray arrayWithCapacity:MAX_VEDIO];
    }
    return _imgArr;
}

- (NSMutableArray *)goodArr {
    if (!_goodArr) {
        _goodArr = [NSMutableArray arrayWithCapacity:MAX_VEDIO];
    }
    return _goodArr;
}

- (NSMutableArray *)commentArr {
    if (!_commentArr) {
        _commentArr = [NSMutableArray arrayWithCapacity:MAX_VEDIO];
    }
    return _commentArr;
}

@end
