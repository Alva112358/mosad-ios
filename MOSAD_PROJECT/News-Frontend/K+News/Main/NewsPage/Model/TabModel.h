//
//  TabModel.h
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef TabModel_h
#define TabModel_h

@interface TabModel : NSObject
@property (nonatomic) NSNumber * len;
@property (nonatomic, strong) NSArray * names;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

#endif /* TabModel_h */
