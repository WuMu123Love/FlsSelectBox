//
//  FLSFiltrateCell.m
//  FlsSelectBox
//
//  Created by fls on 2019/5/5.
//  Copyright © 2019年 fls. All rights reserved.
//

#import "FLSFiltrateCell.h"
#import "NSBundle+FLSubBundle.h"

@interface FLSFiltrateCell()
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;

@end

@implementation FLSFiltrateCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle FLS_subBundleWithBundleName:@"FlsSelectBox" targetClass:[self class]] loadNibNamed:@"FLSFiltrateCell" owner:self options:nil].lastObject;
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.itemTitle.layer.masksToBounds = YES;
    self.itemTitle.layer.cornerRadius  = 30/2.0;
    
    
}

- (void)setModel:(NSDictionary *)model{
    _model = model;
    self.itemTitle.text = model[@"title"];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (selected) {
        self.itemTitle.backgroundColor = [UIColor blueColor];

    }else{
        self.itemTitle.backgroundColor = [UIColor whiteColor];

    }
    
}

@end
