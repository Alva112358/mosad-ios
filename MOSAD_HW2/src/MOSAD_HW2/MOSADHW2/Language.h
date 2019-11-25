//
//  Language.h
//  MOSAD_HW2
//
//  Created by 梁俊华 on 2019/9/2.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#ifndef Language_h
#define Language_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Language : NSObject {
    NSInteger progress_tour;
    NSInteger progress_unit;
}

- (void)learnOneUnit;
- (NSInteger)getTour;
- (NSInteger)getUnit;
- (bool)isFinish;
- (NSString *)getName;

@end

@interface English : Language {
    
}

@end

@interface Japanese : Language {
    
}

@end

@interface German : Language {
    
}

@end

@interface Spanish : Language {
    
}

@end

NS_ASSUME_NONNULL_END



#endif /* Language_h */
