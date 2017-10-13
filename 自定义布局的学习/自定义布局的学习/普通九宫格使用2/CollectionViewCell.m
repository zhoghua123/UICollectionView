//
//  CollectionViewCell.m
//  自定义布局的学习
//
//  Created by xyj on 2017/10/10.
//  Copyright © 2017年 xyj. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
//只会调用这个方法,不会调用init方法
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
//
//-(instancetype)init{
//    if (self = [super init]) {
//        [self setup];
//    }
//    return self;
//}

-(void)setup{
    self.backgroundColor = [UIColor redColor];
    NSLog(@"调用了");
    //在这里添加子控件
}
@end
