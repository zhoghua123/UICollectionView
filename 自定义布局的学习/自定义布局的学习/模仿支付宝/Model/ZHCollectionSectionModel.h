//
//  ZHCollectionSectionModel.h
//  自定义布局的学习
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 xyj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHCollectionSectionModel : NSObject
@property (nonatomic, assign) BOOL isLine;//是否有分割线
@property (nonatomic, assign) BOOL isSubtitle; //是否有子标题
@property (nonatomic, assign) BOOL isRightBtn; //是否有右边按钮
@property (nonatomic,copy) NSString *title; 
@property (nonatomic,copy) NSString *subTitle;
+(NSMutableArray *)getSectionDataArray;
@end

NS_ASSUME_NONNULL_END
