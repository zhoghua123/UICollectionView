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
        _pic = dic[@"pic"];
        _isAdd = NO;
        _isTitle = YES;
        _isRightBtn  = NO;
    }
    return self;
}

-(ZHConnectionModel *)datacopy{
    ZHConnectionModel *model = [[ZHConnectionModel alloc] init];
    model.title = self.title;
    model.pic = self.pic;
    model.isTitle = self.isTitle;
    model.isRightBtn = self.isRightBtn;
    model.isAdd = self.isAdd;
    return model;
}
@end
