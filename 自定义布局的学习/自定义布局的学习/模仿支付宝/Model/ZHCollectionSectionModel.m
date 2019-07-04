//
//  ZHCollectionSectionModel.m
//  自定义布局的学习
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 xyj. All rights reserved.
//

#import "ZHCollectionSectionModel.h"

@implementation ZHCollectionSectionModel
+(NSMutableArray *)getSectionDataArray{
    NSMutableArray *tempArray = [NSMutableArray array];
    ZHCollectionSectionModel *model1 = [[ZHCollectionSectionModel alloc] init];
    model1.isLine = YES;
    model1.isRightBtn = YES;
    model1.isSubtitle = NO;
    model1.title = @"首页功能";
    model1.subTitle = @"(按住拖动调整顺序)";
    ZHCollectionSectionModel *model2 = [[ZHCollectionSectionModel alloc] init];
    model2.isLine = YES;
    model2.isRightBtn = NO;
    model2.isSubtitle = NO;
    model2.title = @"全部功能";
    model2.subTitle = @"";
    [tempArray addObject:model1];
    [tempArray addObject:model2];
    return tempArray;
}
@end
