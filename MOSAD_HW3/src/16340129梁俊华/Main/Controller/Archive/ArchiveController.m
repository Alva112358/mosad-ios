//
//  ArchiveController.m
//  16340129梁俊华
//
//  Created by 梁俊华 on 2019/9/28.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArchiveController.h"
#define RADIUS 55
#define CELL_LEFT  @"right"
#define CELL_RIGHT @"right"

@interface ArchiveController() <UITableViewDelegate, UITableViewDataSource> {
    NSInteger tag;
    UIButton * _btn;
    UISegmentedControl * _sc;
    UINavigationController * _nav;
}

@property (nonatomic, strong) UITableView * UserLeftTable;

@property (nonatomic, strong) UITableView * UserRightTable;

@end

@implementation ArchiveController

@synthesize info = _info;
@synthesize setting = _setting;

- (id)initWithNav:(UINavigationController *)nav {
    _nav = nav;
    return self;
}

- (void)viewDidLoad {
    _info = [@[@"用户名", @"邮箱"] mutableCopy];
    _setting = [@[@"返回语言选择", @"退出登陆"] mutableCopy];
    
    [super viewDidLoad];
    [self setupButton];
    [self setupSegmented];
    [self setTable];
}

- (void)setInfo:(NSArray<NSString *> *)info {
    if (_info != info)  {
        _info = info;
        [self.UserLeftTable reloadData];
    }
}

- (void)setSetting:(NSArray<NSString *> *)setting {
    if (_setting != setting)  {
        _setting = setting;
        [self.UserRightTable reloadData];
    }
}

- (UITableView *)UserLeftTable {
    if (!_UserLeftTable) {
        _UserLeftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 390, self.view.frame.size.width, 500) style:UITableViewStyleGrouped];
        _UserLeftTable.delegate = self;
        _UserLeftTable.dataSource = self;
    }
    return _UserLeftTable;
}

- (UITableView *)UserRightTable {
    if (!_UserRightTable) {
        _UserRightTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 390, self.view.frame.size.width, 500) style:UITableViewStyleGrouped];
        _UserRightTable.delegate = self;
        _UserRightTable.dataSource = self;
    }
    return _UserRightTable;
}

- (void)setupButton {
    _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn.frame = CGRectMake(self.view.frame.size.width / 2 - RADIUS, 190, 110, 110);
    _btn.backgroundColor = [UIColor colorWithRed:134 / 255.0 green:206 / 255.0 blue:236 / 255.0 alpha:1];
    
    // 设置文本.
    [_btn setTitle:@"Login" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // Bezier画圆.
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:_btn.bounds cornerRadius:_btn.frame.size.width / 2];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _btn.bounds;
    maskLayer.path = maskPath.CGPath;
    _btn.layer.mask = maskLayer;
    
    [self.view addSubview:_btn];
}

- (void)setupSegmented {
    _sc = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"用户信息", @"用户设置", nil]];
    _sc.frame = CGRectMake(0, 350, self.view.frame.size.width, 40);
    _sc.backgroundColor = [UIColor colorWithRed:134 / 255.0 green:206 / 255.0 blue:236 / 255.0 alpha:1];
    _sc.selectedSegmentIndex = 0;
    _sc.tintColor = [UIColor whiteColor];
    tag = 0;
    [_sc addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_sc];
}

- (void)setTable {
    [self.UserLeftTable registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_LEFT];
    [self.view addSubview:_UserLeftTable];
    
    [self.UserRightTable registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_LEFT];
    [self.view addSubview:_UserRightTable];
}

- (void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender {
    NSInteger selectIndex = sender.selectedSegmentIndex;
    NSLog(@"Enter selection!");
    switch(selectIndex) {
        case 0:
            NSLog(@"Select 0");
            _UserLeftTable.hidden = NO;
            _UserRightTable.hidden = YES;
            sender.selectedSegmentIndex = 0;
            [_UserLeftTable reloadData];
            tag = 0;
            break;
            
        case 1:
            NSLog(@"Select 1");
            _UserLeftTable.hidden = YES;
            _UserRightTable.hidden = NO;
            sender.selectedSegmentIndex = 1;
            [_UserRightTable reloadData];
            tag = 1;
            break;
            
        default:
            break;
    }
}

- (void)gotoMain {
    NSLog(@"Return to root viewcontroller");
    NSArray * array = [_nav viewControllers];
    NSLog(@"%ld", [array count]);
    [_nav popToRootViewControllerAnimated:YES];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tag == 0) {
        // UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_LEFT];
        UITableViewCell *  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_LEFT];
        
        cell.textLabel.text = _info[indexPath.row];
        cell.detailTextLabel.text = @"未登录";
        return cell;
    } else if (tag == 1) {
        // UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_LEFT];
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_LEFT];
        
        cell.textLabel.text = _setting[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tag == 1 && indexPath.row == 0) {
        [self gotoMain];
    }
        
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
