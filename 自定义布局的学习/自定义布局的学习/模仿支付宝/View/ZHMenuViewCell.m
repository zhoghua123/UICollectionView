//
//  ZHMenuViewCell.m
//  自定义布局的学习
//
//  Created by mac on 2019/7/5.
//  Copyright © 2019 xyj. All rights reserved.
//

#import "ZHMenuViewCell.h"
#import "ZHConnectionModel.h"
@interface ZHMenuViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureOffCons;
@property (weak, nonatomic) IBOutlet UIButton *addDebtn;
@property (weak, nonatomic) IBOutlet UIImageView *coimageView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation ZHMenuViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    NSLog(@"-----------:%f",_pictureOffCons.constant);
    [self.addDebtn addTarget:self action:@selector(addDe) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setModel:(ZHConnectionModel *)model{
    _model = model;
    
    if (model.isVirtual) {
        _title.hidden = YES;
        _coimageView.image = [UIImage imageNamed:@"icon_bala29"];
        _addDebtn.hidden = YES;
        _pictureOffCons.constant = 0;
        self.contentView.backgroundColor = UIColor.whiteColor;
    }else{
        self.contentView.backgroundColor = UIColor.lightGrayColor;
        _title.text = model.title;
        _coimageView.image = [UIImage imageNamed:model.pic];
        _addDebtn.hidden = !model.isRightBtn;
        _title.hidden = !model.isTitle;
        [_addDebtn setImage:[UIImage imageNamed: model.isAdd ? @"icon_bala29" : @"icon_bala30"] forState:UIControlStateNormal];
        if (!model.isTitle ) {
            self.contentView.layer.cornerRadius = self.frame.size.width *0.5;
            self.contentView.layer.masksToBounds = YES;
            _pictureOffCons.constant = 0;
        }else{
            self.contentView.layer.cornerRadius = 0;
            self.contentView.layer.masksToBounds = NO;
            _pictureOffCons.constant = -8;
        }
    }
}
-(void)addDe{
    if (!_model.isRightBtn) return;
    self.addDele(_model.isAdd);
}
@end
