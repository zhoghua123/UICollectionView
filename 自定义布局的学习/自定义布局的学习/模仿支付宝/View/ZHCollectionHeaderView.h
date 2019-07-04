//
//  ZHCollectionHeaderView.h
//  自定义布局的学习
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 xyj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHCollectionSectionModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZHCollectionHeaderView : UICollectionReusableView
@property (nonatomic,strong) ZHCollectionSectionModel *model;
@property (nonatomic,copy) void(^selectAction)(BOOL isselect);
@end

NS_ASSUME_NONNULL_END
