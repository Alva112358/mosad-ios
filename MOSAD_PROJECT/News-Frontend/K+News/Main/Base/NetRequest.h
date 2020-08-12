//
//  NetRequest.h
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef NetRequest_h
#define NetRequest_h

@interface NetRequest : NSObject

+ (id)shareInstance;

- (void)GET:(NSString *)url
     params:(NSMutableDictionary *)params
   progress:(void(^)(id downloadProgress))progress
    success:(void(^)(id responseObject))success
    failues:(void(^)(id error))failure;

- (void)SynGET:(NSString *)url
        params:(NSMutableDictionary *)params
      progress:(void(^)(id downloadProgress))progress
       success:(void(^)(id responseObject))success
       failues:(void(^)(id error))failure;

- (void)POST:(NSString *)url
      params:(NSMutableDictionary *)params
    progress:(void(^)(id downloadProgress))progress
     success:(void(^)(id responseObject))success
     failues:(void(^)(id error))failure;

@end

#endif /* NetRequest_h */
