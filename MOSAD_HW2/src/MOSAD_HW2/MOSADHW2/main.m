//
//  main.m
//  MOSADHW2
//
//  Created by 梁俊华 on 2019/9/7.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Language.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
        // define people and languages.
        NSArray * Person = @[@"张三", @"李四", @"王五"];
        Language * english  = [[English alloc] init];
        Language * spanish  = [[Spanish alloc] init];
        Language * japanese = [[Japanese alloc] init];
        Language * german   = [[German alloc] init];
        NSArray * languages = @[english, spanish, japanese, german];
        
        // choose a person and a language.
        int person_number = arc4random() % 3;
        int language_number = arc4random() % 4;
        NSString * person = [Person objectAtIndex:person_number];
        Language * language = [languages objectAtIndex:language_number];
        
        // Define the format of date.
        NSDateFormatter * df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy年MM月dd日"];
        NSTimeInterval oneDay = 24*60*60*1;
        
        // Learning.
        NSUInteger dayAfter = 0;
        while (![language isFinish]) {
            NSDate * newDay = [NSDate dateWithTimeIntervalSinceNow:oneDay*dayAfter];
            [language learnOneUnit];
            NSLog(@"%@ %@ 学习%@ tour %ld unit %ld", person, [df stringFromDate:newDay], [language getName], [language getTour], [language getUnit]);
            int interval = arc4random() % 5 + 1;
            dayAfter += interval;
        }
    }
}
