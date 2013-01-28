//
//  FrontSummlyView.m
//  Summly
//
//  Created by zzlmilk on 12-12-11.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "FrontSummlyView.h"
#import "Cover.h"


#define left 20

@implementation FrontSummlyView
@synthesize summly;

-(void)pushToDetailVC{
    
    if ([self.delegate respondsToSelector:@selector(pushToDetailVCDelegate)]) {
        [self.delegate pushToDetailVCDelegate];
    }

}

- (NSString *) stringChangeRows:(NSString *)word
{
    NSMutableString *Temp = [NSMutableString string];
    
    if (word.length<=9) {
        [Temp appendFormat:@"%@",[word substringWithRange:NSMakeRange(0, word.length)]];
    }else{
        [Temp appendFormat:@"%@",[word substringToIndex:9]];
        [Temp appendFormat:@"\n"];
        [Temp appendFormat:@"%@",[word substringWithRange:NSMakeRange(10, 9)]];
        [Temp appendFormat:@"..."];
    }
    return Temp;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        int y = self.frame.size.height-180;
        
//        self.coverArr=[[NSDictionary alloc] init];
       [Cover getDefaultCoverParameters:nil WithBlock:^(Summly *_summly) {
           self.summly=_summly;
//            self.coverArr=(NSDictionary *)summlys;
           
           //标题内容
           UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
           [titleBtn setFrame:CGRectMake(20-5, y+23, 230, 60)];
           //titleLabel.text = @"Mailbox：Sparrow 和 Clear 附身的 iPhone 邮件客户端";
           [titleBtn setTitle:[self stringChangeRows:_summly.title] forState:UIControlStateNormal];
//           titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
           titleBtn.titleLabel.numberOfLines=2;
           titleBtn.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
           titleBtn.titleLabel.textColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.9f];
           [titleBtn.titleLabel setBackgroundColor:[UIColor clearColor]];
           titleBtn.titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:23];
           titleBtn.titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
           [titleBtn addTarget:self action:@selector(pushToDetailVC) forControlEvents:UIControlEventTouchUpInside];
           [self addSubview: titleBtn];
           
           
           
           //分隔按钮
           UIImageView  *trendingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,titleBtn.frame.size.height+titleBtn.frame.origin.y+5,120,23)];
           trendingImageView.image = [UIImage imageNamed:@"trending-label.png"];//加载入图片
           [self addSubview:trendingImageView];
           
           
           UILabel *consourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, trendingImageView.frame.size.height+trendingImageView.frame.origin.y-10, 120, 17)];
           consourceLabel.backgroundColor = [UIColor clearColor];
           consourceLabel.text = @"近日趋势";
           consourceLabel.font = [UIFont fontWithName:@"Heiti SC" size:15];
           consourceLabel.textColor = [UIColor whiteColor];
           [self addSubview:consourceLabel];
           
           
           UILabel *mediaLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, consourceLabel.frame.size.height+consourceLabel.frame.origin.y+5, 175, 30)];
           mediaLabel.backgroundColor = [UIColor clearColor];
           mediaLabel.text = _summly.describe;
           mediaLabel.font = [UIFont fontWithName:@"Heiti SC" size:11];
           mediaLabel.numberOfLines=2;
           mediaLabel.lineBreakMode = UILineBreakModeTailTruncation;
           mediaLabel.textColor = [UIColor whiteColor];
           [self addSubview:mediaLabel];
           
           
//           UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, mediaLabel.frame.size.height+mediaLabel.frame.origin.y+2, 120, 13)];
//           typeLabel.backgroundColor = [UIColor clearColor];
//           typeLabel.text = @"Technology";
//           typeLabel.font = [UIFont fontWithName:@"Heiti SC" size:11];
//           typeLabel.textColor = [UIColor whiteColor];
//           [self addSubview:typeLabel];
           

           
        }];
        
        
        //设定当前日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [NSDate date];
        NSString * s = [dateFormatter stringFromDate:date];
        NSArray *array = [s componentsSeparatedByString:@"/"];
        NSString *day = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, 0, 140, 66)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.text = day;
        timeLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:60];
        
        
        timeLabel.textColor = [UIColor whiteColor];
        [self addSubview:timeLabel];
        
        
        UILabel *riLabel = [[UILabel alloc]initWithFrame:CGRectMake(left+70, 25, 170, 32)];
        riLabel.backgroundColor = [UIColor clearColor];
        riLabel.text = @"日";
        riLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:28];
        riLabel.textColor = [UIColor whiteColor];
        [self addSubview:riLabel];
        
        
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps;
        comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                
                           fromDate:date];
        
        NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
        NSArray *weekdic = [[NSArray alloc] initWithObjects:@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",nil];
        UILabel *unreadLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, 60, 200, 35)];
        unreadLabel.backgroundColor = [UIColor clearColor];
        unreadLabel.text = [weekdic objectAtIndex:weekday-1];
        unreadLabel.font = [UIFont fontWithName:@"Thonburi" size:33];
        unreadLabel.textColor = [UIColor whiteColor];
        [self addSubview:unreadLabel];
        
        
        UILabel *doudouLabel = [[UILabel alloc]initWithFrame:CGRectMake(left+2, 114, 140, 14)];
        doudouLabel.backgroundColor = [UIColor clearColor];
        doudouLabel.text = @"DOU DOU Technologies";
        doudouLabel.font = [UIFont fontWithName:@"Heiti SC" size:10];
        doudouLabel.textColor = [UIColor whiteColor];

        [self addSubview:doudouLabel];
        
        
        UILabel *summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(left+2, 99, 140, 15)];
        summaryLabel.backgroundColor = [UIColor clearColor];
        summaryLabel.text = @"豆  豆  科  技  咨  讯";

        [summaryLabel sizeThatFits:CGSizeMake(140, 15)];
        summaryLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:13];
        summaryLabel.textColor = [UIColor whiteColor];
        [self addSubview:summaryLabel];
        
        
                
        //回退按钮
        //        UIImageView  *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(270,10,34,34)];
        //        backImageView.image = [UIImage imageNamed:@"cover-arrow@2x.png"];//加载入图片
        //        [self addSubview:backImageView];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton = [[UIButton alloc]initWithFrame:CGRectMake(270,25,35,30)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"cover-arrow-new@2x.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backbuttonCheck) forControlEvents:UIControlEventTouchDown];
        [self addSubview:backButton];
        
        UIImageView  *trendingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(260,self.frame.size.height-80,37.5,37.5)];
        trendingImageView.image = [UIImage imageNamed:@"cove-logo.png"];//加载入图片
        [self addSubview:trendingImageView];
        
    }
    
    return self;
}

-(void)backbuttonCheck
{
    [self.delegate backbuttonDidSelect];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
