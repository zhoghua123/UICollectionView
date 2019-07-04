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
-(instancetype)initWithDict:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
