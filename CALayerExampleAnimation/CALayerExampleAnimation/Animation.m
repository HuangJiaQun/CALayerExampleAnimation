//
//  Animation.m
//  课时十三 CALayer动画作业
//
//  Created by 黄嘉群 on 2019/7/11.
//  Copyright © 2019 HJQ. All rights reserved.
//

#import "Animation.h"

@implementation Animation

- (id)initWithString:(NSString *)str ary:(NSArray* )ary
{
    if (self = [super init]) {
        self.str=str;
        self.ary=ary;
    }
    return self;
}

@end
