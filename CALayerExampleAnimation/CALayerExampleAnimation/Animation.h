//
//  Animation.h
//  课时十三 CALayer动画作业
//
//  Created by 黄嘉群 on 2019/7/11.
//  Copyright © 2019 HJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Animation : NSObject

@property (nonatomic ,retain)NSString *str;
@property (nonatomic ,retain)NSArray *ary;



- (id)initWithString:(NSString *)str ary:(NSArray* )ary;

@end

NS_ASSUME_NONNULL_END
