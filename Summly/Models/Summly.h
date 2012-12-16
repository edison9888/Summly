//
//  Summly.h
//  Summly
//
//  Created by zzlmilk on 12-12-10.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Summly : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *describe;
@property(nonatomic,strong)NSString *scource;
@property(nonatomic,strong)NSDate * summlyTime;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *sourceUrl;



- (id)initWithAttributes:(NSDictionary *)attributes;

+(void)getSummlysParameters:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *summlys))block;

@end
