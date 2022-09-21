#import "RadialGradientLayer.h"

@interface RadialGradientLayer()

@end

@implementation RadialGradientLayer
{
    BOOL _needsNewGradient;
    BOOL _startCenterInitialized;
    BOOL _endCenterInitialized;
    BOOL _endRadiusInitialized;
    CGGradientRef _lastGradient;
}

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        self.needsDisplayOnBoundsChange = YES;
        self.masksToBounds = YES;
        _needsNewGradient = YES;
    }

    return self;
}

- (void)setNeedsNewGradient
{
    _needsNewGradient = YES;
    [self setNeedsDisplay];
}

- (void)setColors:(NSArray<UIColor *> *)colors
{
    _colors = colors;
    [self setNeedsNewGradient];
}

- (void)setLocations:(NSArray<NSNumber *> *)locations
{
    _locations = locations;
    [self setNeedsNewGradient];
}

- (void)setStartCenter:(CGPoint)center
{
    _startCenter = center;
    _startCenterInitialized = YES;
    [self setNeedsNewGradient];
}

- (void)setStartRadius:(CGFloat)radius
{
    _startRadius = radius;
    [self setNeedsNewGradient];
}

- (void)setEndCenter:(CGPoint)center
{
    _endCenter = center;
    _endCenterInitialized = YES;
    [self setNeedsNewGradient];
}

- (void)setEndRadius:(CGFloat)radius
{
    _endRadius = radius;
    _endRadiusInitialized = YES;
    [self setNeedsNewGradient];
}

- (void)drawInContext:(CGContextRef)ctx
{
    CGFloat *locations = nil;

    locations = (CGFloat*)malloc(sizeof(CGFloat) * self.colors.count);

    for (NSInteger i = 0; i < _colors.count; i++)
    {
        if (_locations.count > i)
        {
            locations[i] = _locations[i].floatValue;
        }
        else
        {
            locations[i] = (1 / (_colors.count - 1)) * i;
        }
    }

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    NSMutableArray *colors = [[NSMutableArray alloc] initWithCapacity:self.colors.count];
    for (UIColor *color in self.colors) {
        [colors addObject:(id)color.CGColor];
    }
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locations);
    
    free(locations);

    CGColorSpaceRelease(colorSpace);

    CGSize size = self.bounds.size;

    CGPoint defaultCenter = CGPointMake(size.width / 2, size.height / 2);

    CGContextDrawRadialGradient(
        ctx, 
        gradient, 
        _startCenterInitialized ? self.startCenter : defaultCenter, 
        self.startRadius, 
        _endCenterInitialized ? self.endCenter : defaultCenter, 
        _endRadiusInitialized ? self.endRadius : MIN(size.width / 2, size.height / 2), 
        kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation
    );

    CGGradientRelease(gradient);
}

- (void)display {
    [super display];
    
    BOOL hasAlpha = NO;

    for (NSInteger i = 0; i < self.colors.count; i++) {
        hasAlpha = hasAlpha || CGColorGetAlpha(self.colors[i].CGColor) < 1.0;
    }

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, !hasAlpha, 0.0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    [self drawInContext:ref];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    self.contents = (__bridge id _Nullable)(image.CGImage);
    self.contentsScale = image.scale;

    UIGraphicsEndImageContext();
}

@end

