//
//  HJQ_CATransition.h
//  课时十三 CALayer动画作业
//
//  Created by 黄嘉群 on 2019/7/11.
//  Copyright © 2019 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJQ_CATransition : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic)BOOL aswitch;

@property (nonatomic ,retain)UITableView *tableView;
@property (nonatomic ,retain)NSMutableArray *arraydata;
@property (nonatomic ,retain)UIView *view;
@property(nonatomic,retain)CATransition *myanimation;
@property (nonatomic ,retain)UILabel *lab;



@end

NS_ASSUME_NONNULL_END
