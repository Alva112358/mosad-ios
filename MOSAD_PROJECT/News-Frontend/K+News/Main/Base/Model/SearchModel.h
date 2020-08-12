//
//  SearchModel.h
//  News
//
//  Created by tplish on 2020/1/5.
//  Copyright © 2020 Team09. All rights reserved.
//

#ifndef SearchModel_h
#define SearchModel_h

@interface SearchModel : NSObject

- (instancetype)initWithDict:(NSDictionary *)dict;

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * tag;
@property (nonatomic, strong) NSString * detailUrl;


@end

#endif /* SearchModel_h */
