//
//  UpScrollView.h
//  Summly
//
//  Created by zoe on 12-12-27.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Summly.h"

@interface UpScrollView : UIScrollView
{
//    UIImageView *imageBackView;
}
//@property(nonatomic,strong) UIImageView *imageBackView;
@property(nonatomic) NSArray *summlyArrs;
- (id)initWithFrame:(CGRect)frame summlys:(NSArray *)summlys;

@end
