//
//  CollectionHeadView.m
//  自定义布局的学习
//
//  Created by xyj on 2017/10/10.
//  Copyright © 2017年 xyj. All rights reserved.
//

#import "CollectionHeadView.h"

@implementation CollectionHeadView

//-(instancetype)init{
//    if (self = [super init]) {
//        [self setup];
//    }
//    return self;
//}
//只会调用这个方法,不会调用init方法
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(void)setup{

    self.backgroundColor = [UIColor blueColor];
    UILabel *label = [[UILabel alloc] init];;
    label.frame = CGRectMake(0, 0, 100, 30);
    label.text = @"我是头部标题";
    [self addSubview:label];
}
@end
