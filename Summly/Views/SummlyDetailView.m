//
//  SummlyDetailView.m
//  Summly
//
//  Created by zoe on 12-12-17.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "SummlyDetailView.h"
#import "AFNetworking.h"
#import "BundleHelp.h"
#import "CoreTextLabel.h"
#import "REXMail.h"
#import "DetailScrollViewController.h"

#define MarginDic 10

#define rangeLength 20*10

@implementation SummlyDetailView
@synthesize summly,imageBackView,titleBg,acticleView;

- (id)initWithFrame:(CGRect)frame summly:(Summly *)_summly
{
    self = [super initWithFrame:frame];
    if (self) {
        isFavorite=NO;

        mutableArr = [NSMutableArray array];

        sinaShare = [[DDShare alloc] init];
        
        weixingShare = [[DDWeixing alloc] init];
        
        self.summly =_summly;
        self.userInteractionEnabled=YES;
             //标题
        imageBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, frame.size.width, 183.5)];
        NSString *randomImageName = [NSString stringWithFormat:@"grad%d.png", arc4random()%6+1];

        if (_summly.imageUrl!=nil) {
            [imageBackView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_summly.imageUrl]] placeholderImage:[UIImage imageNamed:randomImageName]];
        }
        else{
            imageBackView.image = [UIImage imageNamed:randomImageName];
        }
        [imageBackView setContentMode:UIViewContentModeScaleAspectFill];
        imageBackView.clipsToBounds=YES;
        imageBackView.userInteractionEnabled=YES;
        [self addSubview:imageBackView];

        titleBg = [[UIView alloc] initWithFrame:CGRectMake(0, imageBackView.frame.size.height-110+50, frame.size.width, 60)];
        [titleBg setBackgroundColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.25f]];
        [self addSubview:titleBg];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginDic, 0, frame.size.width-20, 60)];
        titleLabel.userInteractionEnabled=YES;
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setNumberOfLines:2];
        titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [titleLabel setFont:[UIFont fontWithName:@"Heiti SC" size:22]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        titleLabel.text = self.summly.title;
        [titleBg addSubview:titleLabel];
                
        //文章
        acticleView = [[UIView alloc] initWithFrame:CGRectMake(0, imageBackView.frame.size.height, frame.size.width, frame.size.height-imageBackView.frame.size.height)];
        [acticleView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MarginDic, 4, 57/2, 57/2)];
        [iconImageView setImage:[UIImage imageNamed:@"publisherIcon.png"]];
        iconImageView.userInteractionEnabled=YES;
        [acticleView addSubview:iconImageView];
        
        UILabel *pulisherLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.size.width+iconImageView.frame.origin.x+MarginDic, 18, 100, 16)];
        pulisherLabel.userInteractionEnabled=YES;
//        [pulisherLabel setFont:[UIFont boldSystemFontOfSize:11]];
        [pulisherLabel setFont:[UIFont fontWithName:@"Heiti SC" size:11]];
        if (self.summly.scource.length==0) {
            pulisherLabel.text = @"雅虎通讯";
        }
        else{
            pulisherLabel.text = self.summly.scource;
        }
        [pulisherLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        [pulisherLabel setBackgroundColor:[UIColor clearColor]];
        [pulisherLabel sizeToFit];
        [acticleView addSubview:pulisherLabel];
        
        UILabel *timeIntervalLabel = [[UILabel alloc] initWithFrame:CGRectMake(pulisherLabel.frame.size.width+pulisherLabel.frame.origin.x+MarginDic, pulisherLabel.frame.origin.y-1, 100, 16)];
        timeIntervalLabel.userInteractionEnabled=YES;
        [timeIntervalLabel setFont:[UIFont systemFontOfSize:11]];
        [timeIntervalLabel setTextColor:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1.0f]];
        timeIntervalLabel.text=self.summly.time;
        [timeIntervalLabel sizeToFit];
        [timeIntervalLabel setBackgroundColor:[UIColor clearColor]];
        [acticleView addSubview:timeIntervalLabel];
         
        NSString *contentStr =self.summly.describe;
        contentStr = [contentStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        NSString *content  = [contentStr substringWithRange:NSMakeRange(0, rangeLength-10)];
        
        CoreTextLabel *articleLabel = [[CoreTextLabel alloc] initWithFrame:CGRectMake(MarginDic+2, iconImageView.frame.size.height+iconImageView.frame.origin.y+MarginDic*2, frame.size.width-MarginDic*2, acticleView.frame.size.height-(iconImageView.frame.size.height+iconImageView.frame.origin.y+MarginDic)-35)];
        articleLabel.userInteractionEnabled=YES;
        [articleLabel setFont:[UIFont fontWithName:@"Heiti SC" size:16.5]];
        articleLabel.text = contentStr;
        articleLabel.numberOfLines = 0;
        articleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [articleLabel setBackgroundColor:[UIColor clearColor]];
        [articleLabel setTextColor:[UIColor colorWithRed:77/255.0f green:77/255.0f blue:77/255.0f alpha:1.0f]];
        [acticleView addSubview:articleLabel];
        [self addSubview:acticleView];
        
        
        isFavorite =  [self isFavDidSearchIdFromSql];//是否收藏
        imagesUnSave = @[[UIImage imageNamed:@"sina.png"],[UIImage imageNamed:@"weixin.png"],[UIImage imageNamed:@"send_email.png"],[UIImage imageNamed:@"petal-unsave.png"]];
        _menu.buttonImages = imagesUnSave;
        imagesSave = @[[UIImage imageNamed:@"sina.png"],[UIImage imageNamed:@"weixin.png"],[UIImage imageNamed:@"send_email.png"],[UIImage imageNamed:@"save.png"]];
        //花瓣
        _menu = [[FAFancyMenuView alloc] init];
        _menu.userInteractionEnabled=YES;
        faFancyMenuDataSource = [[FAFancyMenuViewDataSource alloc]initWithMeun:_menu delegate:self isFavorite:isFavorite];
        [self addSubview:_menu];
        

        UIImageView *fingerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"click"]];
        [fingerImageView setFrame:CGRectMake(270, self.frame.size.height-5-40, 73/2, 45)];
        [self addSubview:fingerImageView];
        
    }
    return self;
}

//花瓣按钮
-(void)fancyMenu:(FAFancyMenuView *)menu didSelectedButtonAtIndex:(NSUInteger)index{
    //新浪分享
    if (index==0) {
        if (sinaShare.sinaWeibo.accessToken==nil) {
            [sinaShare sinaLogin];
            [sinaShare shareContentToSinaWeibo:self.summly.title];
        }
        else
            [sinaShare shareContentToSinaWeibo:self.summly.title];
        
    }
    //微信
    else if (index==1) {
        
        [weixingShare sendMusicContent:self.summly.title];
    }
    //收藏
    else if (index==3) {        
        isFavorite = [self isFavDidSearchIdFromSql];//已经收藏删除
        
        if (isFavorite) {
            if (zoeDebug) {
                NSLog(@"删除%d",self.summly.idenId);
            }
            _menu.buttonImages=imagesSave;
            [self.summly deleteFaviDB:summly];
        }
        else if(isFavorite==NO){//未收藏
            if (zoeDebug) {
                NSLog(@"收藏");
            }
            _menu.buttonImages=imagesUnSave;
            [self.summly insertFavDB:summly];
        }
    }
    //email
    else if(index==2){
        [self performSelector:@selector(sendEmail) withObject:self afterDelay:0.2f];

    }
}

//搜索是否搜藏，返回yes，已收藏
- (BOOL)isFavDidSearchIdFromSql{
    BOOL isFav=NO;

    NSMutableArray *identiIdArr = [NSMutableArray array];
    
    NSArray *summlyArr = [Summly summlysFaviWithParameters];
    for (int i=0; i<summlyArr.count; i++) {
        Summly *sum = [summlyArr objectAtIndex:i];
        [identiIdArr addObject:[NSNumber numberWithInt:sum.idenId]];
        NSNumber *idenId;
        for (idenId in identiIdArr) {
            if ([[NSNumber numberWithInt:self.summly.idenId] isEqualToNumber:idenId]) {
                isFav=YES;

            }
            
        }
    }

    return isFav;
}

- (void)sendEmail{
    REXMail *sendMail = [[REXMail alloc] init];
    [self.controller addChildViewController:sendMail];
    [sendMail sendMailInApp];

}

- (void)dismissDetailViewAnimate:(void (^)())block{

    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        [titleBg setFrame:CGRectMake(0, -(imageBackView.frame.size.height-110+50),320, 60)];

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            [imageBackView setFrame:CGRectMake(0, -imageBackView.frame.size.height,  320, 183.5)];

        } completion:^(BOOL finished) {
            
        }];
    }];


    [UIView animateWithDuration:0.5f animations:^{
        acticleView.alpha=0.0f;
    } completion:^(BOOL finished) {
        block();
    }];
}

-(void)showDetailViewAnimate{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [titleBg setFrame:CGRectMake(0,imageBackView.frame.size.height-110+50, 320, 60)];
        [imageBackView setFrame:CGRectMake(0, 0,  320, 183.5)];
    } completion:^(BOOL finished) {
    }];
    
    
    [UIView animateWithDuration:0.3f animations:^{
        acticleView.alpha=1.0f;
    } completion:^(BOOL finished) {

    }];

}


@end
