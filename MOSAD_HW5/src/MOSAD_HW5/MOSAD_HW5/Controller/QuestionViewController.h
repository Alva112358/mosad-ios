//
//  QuestionViewController.h
//  MOSAD_HW5
//
//  Created by 梁俊华 on 2019/11/2.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#ifndef QuestionViewController_h
#define QuestionViewController_h
#import "ChoiceCell.h"

@interface QuestionViewController : UIViewController

@property (strong, nonatomic) NSString * unit;

@property (strong, nonatomic) NSString * num;

@property (nonatomic) NSInteger proc;

@property (strong, nonatomic) NSMutableArray<NSString *> * dataSource;

@end

#endif /* QuestionViewController_h */
