//
//  LoginModel.h
//  News
//
//  Created by tplish on 2019/12/20.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef LoginModel_h
#define LoginModel_h

@interface LoginModel : NSObject

- (instancetype)initWithDict:(NSDictionary *)dict;

@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * success;

@end

#endif /* LoginModel_h */
