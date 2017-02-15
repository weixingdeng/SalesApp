//
//  EHISegmentedControl.m
//  MobileSales
//
//  Created by dengwx on 2017/2/15.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHISegmentedControl.h"

@interface EHISegmentedControl()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, readwrite) CGFloat segmentWidth;

@property (nonatomic, strong) CALayer *selectionIndicatorStripLayer;

@property (nonatomic, readwrite) NSArray *segmentWidthsArray;

@end

@implementation EHISegmentedControl

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithSectionTitles:(NSArray *)sectiontitles {
    self = [self initWithFrame:CGRectZero];
    
    if (self) {
        [self commonInit];
        self.sectionTitles = sectiontitles;
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.segmentWidth = 0.0f;
    [self commonInit];
}


- (void)commonInit
{
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.scrollsToTop = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    self.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18.0f];
    self.textColor = [UIColor blackColor];
    self.selectedTextColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.opaque = NO;
    self.selectionIndicatorColor = [UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
    
    self.selectedSegmentIndex = 0;
    self.selectionIndicatorHeight = 5.0f;
    
    self.selectionIndicatorStripLayer = [CALayer layer];

    self.contentMode = UIViewContentModeRedraw;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateSegmentsRects];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self updateSegmentsRects];
}

- (void)setSectionTitles:(NSArray *)sectionTitles {
    _sectionTitles = sectionTitles;
    
    [self setNeedsLayout];
}
- (NSUInteger)sectionCount {
    
    return self.sectionTitles.count;
   
}
- (void)updateSegmentsRects {
    self.scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    // When `scrollEnabled` is set to YES, segment width will be automatically set to the width of the biggest segment's text or image,
    // otherwise it will be equal to the width of the control's frame divided by the number of segments.
    if ([self sectionCount] > 0) {
        self.segmentWidth = self.frame.size.width / [self sectionCount];
    }
    
for (NSString *titleString in self.sectionTitles) {
#if  __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
            CGFloat stringWidth = [titleString sizeWithAttributes:@{NSFontAttributeName: self.font}].width ;
#else
            CGFloat stringWidth = [titleString sizeWithFont:self.font].width ;
#endif
            self.segmentWidth = MAX(stringWidth, self.segmentWidth);
}
    
    
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake([self totalSegmentedControlWidth], self.frame.size.height);
}

- (CGFloat)totalSegmentedControlWidth {
    return self.sectionTitles.count * self.segmentWidth;
   
}

- (void)drawRect:(CGRect)rect {
    [self.backgroundColor setFill];
    UIRectFill([self bounds]);
    
    // Remove all sublayers to avoid drawing images over existing ones
    self.scrollView.layer.sublayers = nil;
    

        [self.sectionTitles enumerateObjectsUsingBlock:^(id titleString, NSUInteger idx, BOOL *stop) {
            
            CGFloat stringHeight = ceilf([titleString sizeWithAttributes:@{NSFontAttributeName: self.font}].height);
            CGFloat stringWidth = ceilf([titleString sizeWithAttributes:@{NSFontAttributeName: self.font}].width);
            
            // Text inside the CATextLayer will appear blurry unless the rect values are rounded
            CGFloat y = roundf(CGRectGetHeight(self.frame) - self.selectionIndicatorHeight)/2 - stringHeight/2 ;
            
            CGRect rect;
            
            rect = CGRectMake((self.segmentWidth * idx) + (self.segmentWidth - stringWidth)/2, y, stringWidth, stringHeight);
           
            
            CATextLayer *titleLayer = [CATextLayer layer];
            titleLayer.frame = rect;
            titleLayer.font = (__bridge CFTypeRef)(self.font.fontName);
            titleLayer.fontSize = self.font.pointSize;
            titleLayer.alignmentMode = kCAAlignmentCenter;
            titleLayer.string = titleString;
            titleLayer.truncationMode = kCATruncationEnd;
            
            if (self.selectedSegmentIndex == idx) {
                titleLayer.foregroundColor = self.selectedTextColor.CGColor;
            } else {
                titleLayer.foregroundColor = self.textColor.CGColor;
            }
            
            titleLayer.contentsScale = [[UIScreen mainScreen] scale];
            [self.scrollView.layer addSublayer:titleLayer];
        }];
    
    // Add the selection indicators
    if (self.selectedSegmentIndex != -1) {
        if (!self.selectionIndicatorStripLayer.superlayer) {
                self.selectionIndicatorStripLayer.frame = [self frameForSelectionIndicator];
                [self.scrollView.layer addSublayer:self.selectionIndicatorStripLayer];
                
            
            }
        }
}

- (CGRect)frameForSelectionIndicator {
    CGFloat indicatorYOffset = 0.0f;
    
    
    indicatorYOffset = self.bounds.size.height - self.selectionIndicatorHeight;
    
    
    CGFloat sectionWidth = 0.0f;
    
    CGFloat stringWidth = [[self.sectionTitles objectAtIndex:self.selectedSegmentIndex] sizeWithAttributes:@{NSFontAttributeName: self.font}].width;
        sectionWidth = stringWidth;
       
  
    
    return CGRectMake(self.segmentWidth * self.selectedSegmentIndex, indicatorYOffset, self.segmentWidth, self.selectionIndicatorHeight);
    
}


@end
