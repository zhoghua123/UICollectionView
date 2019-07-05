//
//  ZHMenuViewCell.h
//  自定义布局的学习
//
//  Created by mac on 2019/7/5.
//  Copyright © 2019 xyj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHConnectionModel;
NS_ASSUME_NONNULL_BEGIN

@interface ZHMenuViewCell : UICollectionViewCell
@property (nonatomic,strong) ZHConnectionModel *model;
@property (nonatomic,copy) void (^addDele)(BOOL isAdd);
@end

NS_ASSUME_NONNULL_END
