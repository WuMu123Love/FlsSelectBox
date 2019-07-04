//
//  NSBundle+FLSubBundle.h
//  FLabelKit
//
//  Created by fls on 2019/7/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (FLSubBundle)
//bundleName是和组件名字一样的
+ (instancetype)FLS_subBundleWithBundleName:(NSString *)bundleName targetClass:(Class)targetClass;
@end

NS_ASSUME_NONNULL_END
