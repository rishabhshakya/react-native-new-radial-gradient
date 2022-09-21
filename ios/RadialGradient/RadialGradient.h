#import <UIKit/UIKit.h>
#import <React/RCTViewComponentView.h>

NS_ASSUME_NONNULL_BEGIN

@interface RadialGradient : RCTViewComponentView
- (void)setColors:(NSArray<UIColor *> *)colors;
@end

NS_ASSUME_NONNULL_END
