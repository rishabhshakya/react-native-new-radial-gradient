#import "RadialGradient.h"
#import <React/RCTBridge.h>
#import <React/RCTViewManager.h>

@interface RadialGradientManager : RCTViewManager
@end

@implementation RadialGradientManager

RCT_EXPORT_MODULE(RadialGradientView);

- (RadialGradient *)view
{
    return [[RadialGradient alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(colors, NSArray);
RCT_EXPORT_VIEW_PROPERTY(center, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(radius, CGFloat);
RCT_EXPORT_VIEW_PROPERTY(stops, NSArray);

@end
