//
//  ZHConnectionModel.m
//  自定义布局的学习
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 xyj. All rights reserved.
//

#import "ZHConnectionModel.h"

@implementation ZHConnectionModel
-(instancetype)initWithDict:(NSDictionary *)dic{
    if (self = [super init]) {
        _title = dic[@"title"];
        _pic = dic[@"icon_nav4_c"];
    }
    return self;
}


@end
