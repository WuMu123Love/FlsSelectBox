//
//  FLSFiltrateView.h
//  FlsSelectBox
//
//  Created by fls on 2019/5/5.
//  Copyright © 2019年 fls. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLSFiltrateView : UIView
@property(nonatomic,strong) NSArray  *  titleArray;
@property(nonatomic,strong) NSArray  *  imageArray;
@property(nonatomic,copy) void (^backSelectItemArray)(NSArray * itemArray);

@end

NS_ASSUME_NONNULL_END
