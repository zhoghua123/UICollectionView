//
//  ZHShopViewCell.m
//  自定义布局的学习
//
//  Created by xyj on 2017/10/12.
//  Copyright © 2017年 xyj. All rights reserved.
//

#import "ZHShopViewCell.h"
#import "ZHShop.h"
#import "UIImageView+WebCache.h"
@interface ZHShopViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation ZHShopViewCell

- (void)setShop:(ZHShop *)shop{
    
    
    
    
    _shop = shop;
    // 1.图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    // 2.价格
    self.priceLabel.text = shop.price;
}
@end
