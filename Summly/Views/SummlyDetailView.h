//
//  SummlyDetailView.h
//  Summly
//
//  Created by zoe on 12-12-17.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Summly.h"




@interface SummlyDetailView : UIView
{
}

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIView *acticleView;
@property(nonatomic,strong) UIImageView *imageBackView;
@property(nonatomic,strong) Summly *summly;

- (id)initWithFrame:(CGRect)frame summly:(Summly *)summly;
- (void)dismissDetailViewAnimate:(void (^)())block;
- (void)showDetailViewAnimate;
@end
