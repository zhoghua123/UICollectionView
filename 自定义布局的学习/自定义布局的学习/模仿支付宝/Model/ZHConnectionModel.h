//
//  ZHConnectionModel.h
//  自定义布局的学习
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019 xyj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHConnectionModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *pic;

/*********辅助属性**********/
@property (nonatomic, assign) BOOL isRightBtn; //是否显示右上角btn
@property (nonatomic, assign) BOOL isTitle; //是否需要显示标题
@property (nonatomic, assign) BOOL isAdd;  //是否是加

-(instancetype)initWithDict:(NSDictionary *)dic;

-(ZHConnectionModel *)datacopy;
@end

NS_ASSUME_NONNULL_END
