// This guard prevent the code from being compiled in the old architecture
#ifdef RCT_NEW_ARCH_ENABLED
#import "RadialGradient.h"
#import "RadialGradientLayer.h"

#import <React/RCTConversions.h>
#import <React/RCTConvert.h>

#import <react/renderer/components/RNRadialGradientViewSpecs/ComponentDescriptors.h>
#import <react/renderer/components/RNRadialGradientViewSpecs/EventEmitters.h>
#import <react/renderer/components/RNRadialGradientViewSpecs/Props.h>
#import <react/renderer/components/RNRadialGradientViewSpecs/RCTComponentViewHelpers.h>
#import <UIKit/UIKit.h>

#import "RCTFabricComponentsPlugins.h"

using namespace facebook::react;

@interface RadialGradient () <RCTRadialGradientViewViewProtocol>
@end

@implementation RadialGradient {
    UIView *_view;
    RadialGradientLayer *_layer;
}

+ (Class)layerClass
{
    return [RadialGradientLayer class];
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<RadialGradientViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const RadialGradientViewProps>();
    _props = defaultProps;
    
    _layer = (RadialGradientLayer *)self.layer;
    _view = [[UIView alloc] init];

    self.contentView = _view;
  }
  
  return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &oldViewProps = *std::static_pointer_cast<RadialGradientViewProps const>(_props);
  const auto &newViewProps = *std::static_pointer_cast<RadialGradientViewProps const>(props);

  if(oldViewProps.radius != newViewProps.radius) {
    _layer.startRadius = CGFloat(0);
    _layer.endRadius = CGFloat(newViewProps.radius);
  }

  if(oldViewProps.center != newViewProps.center) {
    _layer.startCenter = CGPointMake(newViewProps.center[0], newViewProps.center[1]);
    _layer.endCenter = CGPointMake(newViewProps.center[0], newViewProps.center[1]);
  }

  NSArray<NSNumber *> *locations = convertCxxVectorNumberToNsArrayNumber(newViewProps.stops);
  _layer.locations = locations;

  // We cannot compare SharedColor because it is shared value.
  // We could compare color value, but it is more performant to just assign new value
  NSArray<UIColor *> *colors = convertCxxVectorColorsToNSArrayColors(newViewProps.colors);
  [self setColors:colors];
  
  [super updateProps:props oldProps:oldProps];
}

- (void)setColors:(NSArray<UIColor *>*)colorStrings
{

    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:colorStrings.count];
    for (NSString *colorString in colorStrings)
    {
        if ([colorString isKindOfClass:UIColor.class])
        {
            [colors addObject:(UIColor *)colorString];
        }
        else
        {
            [colors addObject:(id)[RCTConvert UIColor:colorString].CGColor];
            if([colorStrings count]==1){
                [colors addObject:(id)[[RCTConvert UIColor:colorString] colorWithAlphaComponent:0.5].CGColor];
            }
        }
    }
    _layer.colors = colors;
}

static NSArray<UIColor *> *convertCxxVectorColorsToNSArrayColors(const std::vector<facebook::react::SharedColor> &colors)
{
  size_t size = colors.size();
  NSLog(@"%zu", size);
  NSMutableArray *result = [NSMutableArray new];
  for(size_t i = 0; i < size; i++) {
    UIColor *color = RCTUIColorFromSharedColor(colors[i]);
    [result addObject:color];
  }
  return [result copy];
}


static NSArray<NSNumber *> *convertCxxVectorNumberToNsArrayNumber(const std::vector<Float> &value)
{
  size_t size = value.size();
  NSMutableArray *result = [NSMutableArray new];
  for(size_t i = 0; i < size; i++) {
    NSNumber *number = @(value[i]);
    [result addObject:number];
  }
  return [result copy];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if (aSelector == @selector(displayLayer:))
    {
        return NO;
    }

    return [super respondsToSelector:aSelector];
}

Class<RCTComponentViewProtocol> RadialGradientViewCls(void)
{
  return RadialGradient.class;
}

@end
#endif
