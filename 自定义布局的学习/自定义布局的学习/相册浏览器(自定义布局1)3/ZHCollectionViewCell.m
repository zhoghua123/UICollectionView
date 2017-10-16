//
//  ZHCollectionViewCell.m
//  自定义布局的学习
//
//  Created by xyj on 2017/10/11.
//  Copyright © 2017年 xyj. All rights reserved.
//

#import "ZHCollectionViewCell.h"

@interface ZHCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation ZHCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //图片加边框
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 10;
}
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    _imageView.image = [UIImage imageNamed:imageName];
}
@end
