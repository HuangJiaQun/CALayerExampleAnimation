//
//  HJQ_CATransition.m
//  课时十三 CALayer动画作业
//
//  Created by 黄嘉群 on 2019/7/11.
//  Copyright © 2019 HJQ. All rights reserved.
//

#import "HJQ_CATransition.h"
#import "Animation.h"

@implementation HJQ_CATransition

- (void)dealloc
{
    self.tableView=nil;
    self.arraydata=nil;
    self.view=nil;
    self.lab=nil;
    self.myanimation=nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self initsubviews];
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initsubviews
{
    
//1.  编写一个动画库，展示ios动画。界面描述：左边有一个UITableView，宽度为160个像素，以分组的形式展示动画列表，右边有一个UIImageView用于展示动画，一个开关用于使动画结束后是否复原，一个滑块用于设置动画时间，一个分段组件设置动画方向(从上，从下，从左，从右)。
//    CALayer图层：“圆角", "红边框"
//    UIViewAnimation基础动画："上翻页", "左翻转", "下翻页", "右翻转"
//    CATransition过渡动画："立方体", "推出", "揭开",  "覆盖", "淡出", "吸收",  "翻转",  "波纹",  "上翻页",  "下翻页",  "镜头开",  "镜头关"
    
//-----------------------------------------------------------------------------------------------------------------------------------------
    
//UITableView 列表
    self.backgroundColor=[UIColor whiteColor];
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    CGFloat height=[UIScreen mainScreen].bounds.size.height;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 160, height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;//设置数据源委托
    self.tableView.delegate = self;//设置代理委托
    [self addSubview:self.tableView];
    
    Animation *a1=[[Animation alloc]initWithString:@"CALayer图层" ary:@[@"圆角",@"红边框"]];
    
    Animation *a2=[[Animation alloc]initWithString:@"UIViewAnimation基础动画" ary:@[@"上翻页",@"下翻页",@"左翻转",@"右翻转"]];
    
    Animation *a3=[[Animation alloc]initWithString:@"CATransition过渡动画" ary:@[@"立方体",@"推出",@"揭开",@"覆盖",@"淡出",@"吸收",@"翻转",@"波纹",@"上翻页",@"下翻页",@"镜头开",@"镜头关"]];

    self.arraydata=[NSMutableArray arrayWithObjects:a1,a2,a3, nil];
//-----------------------------------------------------------------------------------------------------------------------------------------
//大图片
    self.view=[[[UIView alloc]initWithFrame:CGRectMake(180, 40, width-200, width-200)]autorelease];
    [self addSubview:self.view];
    
    UIImageView *aview=[[[UIImageView alloc]initWithFrame:self.view.bounds]autorelease];
    aview.image=[UIImage imageNamed:@"1.jpg"];
    aview.tag=777;
    aview.contentMode=UIViewContentModeScaleToFill;
    aview.clipsToBounds=YES;
    [self.view addSubview:aview];
    
    UIImageView *aview2=[[[UIImageView alloc]initWithFrame:self.view.bounds]autorelease];
    aview2.image=[UIImage imageNamed:@"2.jpg"];
    aview2.tag=888;
    aview2.contentMode=UIViewContentModeScaleToFill;
    aview2.clipsToBounds=YES;
    [self.view addSubview:aview2];
    
 
//-----------------------------------------------------------------------------------------------------------------------------------------
//显示屏
    self.lab=[[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+self.view.frame.size.height+5, self.view.frame.size.width, 50)]autorelease];
    self.lab.font=[UIFont systemFontOfSize:22];
    self.lab.textAlignment=NSTextAlignmentLeft;
    self.lab.text=@"当前动画时间:2.00";
    [self addSubview:self.lab];
    
    
//-----------------------------------------------------------------------------------------------------------------------------------------
//添加滑块
    UISlider *slider=[[[UISlider alloc]initWithFrame:CGRectMake(self.lab.frame.origin.x,self.lab.frame.origin.y+self.lab.frame.size.height, self.lab.frame.size.width, 50)]autorelease];
    slider.value = 2.0;//设置起始值
    slider.minimumValue = 0.0;//设置最小值
    slider.maximumValue = 5.0;//设置最大值
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];//设置滑块改变响应方法
    [self addSubview:slider];
    
    //改变滑块背景颜色
    slider.minimumTrackTintColor = [UIColor redColor];//滑块的最小轨道背景颜色
    slider.maximumTrackTintColor = [UIColor blueColor];//滑块的最大轨道背景颜色
    
//-----------------------------------------------------------------------------------------------------------------------------------------
//开关 UISwitch
    
    self.aswitch =NO;
    UISwitch *aSwitch=[[[UISwitch alloc]initWithFrame:CGRectMake(slider.frame.origin.x , slider.frame.origin.y+slider.frame.size.height, 20, 20)]autorelease];
    aSwitch .onTintColor=[UIColor yellowColor];//打开开关时的背景色
    aSwitch.tintColor=[UIColor grayColor];//关闭开关时的背景色
    aSwitch.thumbTintColor=[UIColor blueColor];//开关滑块的颜色
    aSwitch.on=self.aswitch;//设置开关关闭状态
    [aSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:aSwitch];

//-----------------------------------------------------------------------------------------------------------------------------------------
//添加开关提示
    
    UILabel *lab2=[[[UILabel alloc]initWithFrame:CGRectMake(aSwitch.frame.origin.x+60, aSwitch.frame.origin.y, slider.frame.size.width-aSwitch.frame.size.width, aSwitch.frame.size.height)]autorelease];
    lab2.textAlignment=NSTextAlignmentLeft;
    lab2.font=[UIFont systemFontOfSize:20];
    lab2.text=@"是否恢复";
    [self addSubview:lab2];
    
    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(aSwitch.frame.origin.x, aSwitch.frame.origin.y+aSwitch.frame.size.height+10, self.lab.frame.size.width-50, 30)];
    lab3.font=[UIFont systemFontOfSize:20];
    lab3.text=@"动画方向";
    [self addSubview:lab3];
//-----------------------------------------------------------------------------------------------------------------------------------------
//添加分段控件
    UISegmentedControl*segmented=[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"上",@"下", @"左",@"右",nil]];
    segmented.frame=CGRectMake(slider.frame.origin.x  , lab3.frame.size.height+lab3.frame.origin.y+5, slider.frame.size.width, 40);
    segmented.tag=666;
    [segmented addTarget:self action:@selector(segmentedChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:segmented];
    
//-----------------------------------------------------------------------------------------------------------------------------------------
//动画
    //    self.animation888=[CATransition animation];
    //    self.animation888.duration=2;//持续时间
    //    //    self.animation888.type=kCATransitionReveal;//动画类型
    //    //    self.animation888.subtype=kCATransitionFromTop;//动画方向
    //    self.animation888.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//匀速
    
    /**
     type 动画类型
     kCATransitionFade//淡入淡出
     kCATransitionMoveIn//覆盖
     kCATransitionPush//推出
     kCATransitionReveal//滑出
     */
    
    /**
     subtype 动画方向
     kCATransitionFromRight
     kCATransitionFromLeft
     kCATransitionFromTop
     kCATransitionFromBottom
     */
    
    
    self.myanimation=[CATransition animation];
    self.myanimation.duration=2;
//    self.myanimation.type=kCATransitionReveal;
//    self.myanimation.subtype=kCATransitionFromRight;
    //self.myanimation.timingFunction=UIViewAnimationCurveEaseInOut;//动画展现速度
    self.myanimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//动画展现速度
    
    
}

//滑块
#pragma mark 滑块滑动
- (void)sliderAction:(UISlider*)slider
{
    //int a=(int)slider.value;
    self.myanimation.duration=slider.value;
    self.lab.text=[NSString stringWithFormat:@"当前动画时间:%.1f",slider.value];
    self.myanimation.duration=slider.value;
}


////开关 UISwitch
#pragma mark 开关状态改变
- (void)switchAction:(UISwitch*)aSwitch
{
    if (YES == aSwitch.on)
    {
        NSLog(@"开关打开");
        self.aswitch=aSwitch.on;
    }
    else
    {
        NSLog(@"开关关闭");
        self.aswitch=aSwitch.on;
    }
}

#pragma mark 分段控制器改变
- (void)segmentedChange:(UISegmentedControl *)segmented
{
    /**
     subtype 动画方向
     kCATransitionFromRight
     kCATransitionFromLeft
     kCATransitionFromTop
     kCATransitionFromBottom
     */
    switch (segmented.selectedSegmentIndex) {
        case 0:
        {
            self.myanimation.subtype=kCATransitionFromTop;
        }
            break;
        case 1:
        {
            self.myanimation.subtype=kCATransitionFromBottom;
        }
            break;
        case 2:
        {
            self.myanimation.subtype=kCATransitionFromLeft;
        }
            break;
        case 3:
        {
            self.myanimation.subtype=kCATransitionFromRight;
        }
            break;
        default:
            break;
    }
}


-(void)huifu
{
    self.view.layer.cornerRadius=0;//转角半径
    self.view.layer.borderWidth=0;//边框宽度
    
    self.myanimation.type=kCATransitionFade;//淡入淡出
    UIView *view = [self.view viewWithTag:888];
    [self.view bringSubviewToFront:view];//把aView3移动到所有子视图上面
    [[self.view layer] addAnimation:self.myanimation forKey:@"animation"];
    
}



//表格视图的数据原委托
#pragma mark - UITableViewDataSource
//设置每一组的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Animation *keys=[self.arraydata objectAtIndex:section];
    return keys.str;
    
}


//设置表格有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.arraydata count];
}

//设置表格视图每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section//节
{
    if (self.arraydata && [self.arraydata count])
    {
        
        Animation *n=[self.arraydata objectAtIndex:section];
        return [n.ary count];
    }
    return 0;
}

//设置表格视图每一行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //说明：UITableViewCell表示表视图单元格，UITableView里的每一行都是UITableViewCell
    static NSString *cellIdentifier = @"myCell";//定义一个可重用标识
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];//从重用队列里获取可重用的cell
    if (!cell)
    {
        //如果不存在，创建一个可重用cell
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier] autorelease];
        cell.backgroundColor=[UIColor whiteColor];
    }
    
    if (self.arraydata&&indexPath.section < [self.arraydata count])
    {
        Animation *a=[self.arraydata objectAtIndex:indexPath.section];//根据组所引获取当前组对应对象
        cell.textLabel.text=[a.ary objectAtIndex:indexPath.row];
        cell.textLabel.textColor=[UIColor blueColor];
        cell.textLabel.font=[UIFont systemFontOfSize:20];
        
    }
    
    return cell;
}


//表格视图的代理委托
#pragma mark - UITableViewDelegate

//设置每行表格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//选择表格视图某一行调用的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        [self setAnimation1:indexPath];
    }
    if (indexPath.section==1)
    {
        [self setAnimation2:indexPath];
    }
    if (indexPath.section==2)
    {
        [self setAnimation3:indexPath];
    }

}


#pragma mark - 设置CALayer图层：“圆角","红边框"
- (void)setAnimation1:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            self.view.layer.cornerRadius =self.view.bounds.size.width/2;//设置圆角弧度
            self.view.layer.masksToBounds = YES;//超出的部分截掉
            
        }
            break;
        case 1:
        {
            self.view.layer.borderWidth = 1;//设置圆角边框宽度
            self.view.layer.borderColor = [UIColor redColor].CGColor;//设置圆角边框颜色
        }
            break;
            
        default:
            break;
    }
    if (self.aswitch==YES) {
        CGFloat f=self.myanimation.duration+1;
        [self performSelector:@selector(huifu) withObject:nil afterDelay:f];
    }
    else{
        NSLog(@"动画不恢复");
    }
}


#pragma mark - UIViewAnimation基础动画："上翻页", "左翻转", "下翻页", "右翻转"
- (void)setAnimation2:(NSIndexPath *)indexPath
{
    /**
     UIViewAnimationOptionTransitionFlipFromLeft,==ui视图动画选项从左侧翻转
     UIViewAnimationOptionTransitionFlipFromRight,==ui视图动画选项转换从右翻转，，
     UIViewAnimationOptionTransitionCurlUp,==uiview动画选项转换向上弯曲
     UIViewAnimationOptionTransitionCurlDown,==uiview动画选项转换向下弯曲，
     UIViewAnimationOptionTransitionCrossDissolve,==uiview动画选项转换交叉溶解
     UIViewAnimationOptionTransitionFlipFromTop,==uiview动画选项从顶部翻转
     UIViewAnimationOptionTransitionFlipFromBottom==uiview动画选项从底部翻转
     */

    switch (indexPath.row) {
        case 0://"上翻页"
            {
                //block动画语句块
                [UIView transitionWithView:self.view duration:self.myanimation.duration options:UIViewAnimationOptionTransitionCurlUp animations:^{
                    //在parentView执⾏行动画的时候,调换两个视图的位置,以达到视图切换的效果
                    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
                } completion:^(BOOL finished) {
                }];
            }
            break;
        case 1://""下翻页",
        {
            //block动画语句块
            [UIView transitionWithView:self.view duration:self.myanimation.duration options:UIViewAnimationOptionTransitionCurlDown animations:^{
                //在parentView执⾏行动画的时候,调换两个视图的位置,以达到视图切换的效果
                [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
            } completion:^(BOOL finished) {
            }];
        }
            break;
        case 2://"左翻转"
        {
            //block动画语句块
            [UIView transitionWithView:self.view duration:self.myanimation.duration options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                //在parentView执⾏行动画的时候,调换两个视图的位置,以达到视图切换的效果
                [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
            } completion:^(BOOL finished) {
            }];
        }
            break;
        case 3:// "右翻转"
        {
            //block动画语句块
            [UIView transitionWithView:self.view duration:self.myanimation.duration options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                //在parentView执⾏行动画的时候,调换两个视图的位置,以达到视图切换的效果
                [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
            } completion:^(BOOL finished) {
            }];
        }
            break;
        default:
            break;
    }
    
    if (self.aswitch==YES) {
        CGFloat f=self.myanimation.duration+1;
        [self performSelector:@selector(huifu) withObject:nil afterDelay:f];
    }
}

#pragma mark - CATransition过渡动画："立方体", "推出", "揭开",  "覆盖", "淡出", "吸收",  "翻转",  "波纹",  "上翻页",  "下翻页",  "镜头开",  "镜头关"
- (void)setAnimation3:(NSIndexPath *)indexPath
{
    /**
     //私有动画
     animation.type = @"cube"//⽴方体效果
     animation.type = @"reveal";//揭开效果
     animation.type = @"moveIn";//覆盖效果
     animation.type = @"suckEffect"//吸收效果
     animation.type = @"oglFlip"//翻转效果
     animation.type = @"rippleEffect"//波纹效果
     animation.type = @"pageCurl"//向上翻⻚效果
     animation.type = @"pageUnCurl"//向下翻⻚效果
     animation.type = @"cameraIrisHollowOpen"//镜头开
     animation.type = @"cameraIrisHollowClose"//镜头关
     */
    
    /**
     type 动画类型
     kCATransitionFade//淡入淡出
     kCATransitionMoveIn//覆盖
     kCATransitionPush//推出
     kCATransitionReveal//滑出
     */
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    switch (indexPath.row) {
        case 0://"立方体",
        {
            self.myanimation.type=@"cube";
            [self.view.layer addAnimation:self.myanimation forKey:@"animation"];
        }
            break;
        case 1://"推出","
        {
            self.myanimation.type=kCATransitionPush;//推出
            [self.view.layer addAnimation:self.myanimation forKey:@"animation"];
        }
            break;
        case 2:// "揭开"
        {
            self.myanimation.type= @"reveal";//揭开效果
            [self.view.layer addAnimation:self.myanimation forKey:@"animation"];
        }
            break;
        case 3:// "覆盖"
        {
            self.myanimation.type=@"moveIn";//覆盖效果
            [self.view.layer addAnimation:self.myanimation forKey:@"animation"];
        }
            break;
        case 4://"淡出",
        {
            self.myanimation.type= kCATransitionFade;//淡入淡出
            [self.view.layer addAnimation:self.myanimation forKey:@"animation"];
        }
            break;
        case 5:// "吸收",
        {
            self.myanimation.type=@"suckEffect";//吸收效果
            [self.view.layer addAnimation:self.myanimation forKey:@"animation"];
        }
            break;
        case 6://"翻转",
        {
            self.myanimation.type=@"oglFlip";//翻转效果
            [self.view.layer addAnimation:self.myanimation forKey:@"animation"];
        }
            break;
        case 7://"波纹",
        {
            self.myanimation.type=@"rippleEffect";//波纹效果
            [self.view.layer addAnimation:self.myanimation forKey:@"animation"];
        }
            break;
        case 8://"上翻页",
        {
            self.myanimation.type=@"pageCurl";//向上翻⻚效果
            [self.view.layer addAnimation:self.myanimation forKey:@"animation"];
        }
            break;
        case 9:// "下翻页",
        {
            self.myanimation.type=@"pageUnCurl";//向下翻⻚效果
            [self.view.layer addAnimation:self.myanimation forKey:@"animation"];
        }
            break;
        case 10://"镜头开"
        {
            self.myanimation.type=@"cameraIrisHollowOpen";//镜头开
            [self.view.layer addAnimation:self.myanimation forKey:@"animation"];
        }
            break;
        case 11://  "镜头关"
        {
            self.myanimation.type=@"cameraIrisHollowClose";//镜头关
            [self.view.layer addAnimation:self.myanimation forKey:@"animation"];
        }
            break;
        default:
            break;
    }
    
    if (self.aswitch==YES) {
        CGFloat f=self.myanimation.duration+1;
        [self performSelector:@selector(huifu) withObject:nil afterDelay:f];
    }
    
}

@end
