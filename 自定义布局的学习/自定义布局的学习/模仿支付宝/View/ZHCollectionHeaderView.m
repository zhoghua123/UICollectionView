//
//  ZHCollectionHeaderView.m
//  自定义布局的学习
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 xyj. All rights reserved.
//

#import "ZHCollectionHeaderView.h"
#import "ZHCollectionSectionModel.h"
@interface ZHCollectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *leftTitle;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
@implementation ZHCollectionHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.editBtn.layer.cornerRadius = 5;
    self.editBtn.layer.masksToBounds = YES;
    self.editBtn.layer.borderWidth = 1;
    self.editBtn.layer.borderColor = [UIColor colorWithRed:0 green:202.0/255.0 blue:214.0/255.0 alpha:1.0].CGColor;
    [self.editBtn addTarget:self action:@selector(selectActionx) forControlEvents:UIControlEventTouchUpInside];
}
-(void)selectActionx{
    if (!self.model.isRightBtn) return;
    if (self.selectAction) {
        self.selectAction(YES);
    }
}
-(void)setModel:(ZHCollectionSectionModel *)model{
    _model = model;
    _subtitle.hidden = !model.isSubtitle;
    _lineView.hidden = !model.isLine;
    _editBtn.hidden = !model.isRightBtn;
    _leftTitle.text = model.title;
    _subtitle.text = model.isSubtitle ? model.subTitle : @"";
}
@end
