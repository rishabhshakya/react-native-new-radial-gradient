#ifndef RadialGradientLayer_h
#define RadialGradientLayer_h

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@class UIColor;

@interface RadialGradientLayer : CALayer

@property (nullable, nonatomic, copy) NSArray<UIColor *> *colors;
@property (nullable, nonatomic, strong) NSArray<NSNumber *> *locations;
@property (nonatomic) CGPoint startCenter;
@property (nonatomic) CGPoint endCenter;
@property (nonatomic) CGFloat startRadius;
@property (nonatomic) CGFloat endRadius;
- (void)setColors:(NSArray<UIColor *> *)colors;

@end

#endif