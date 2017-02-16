//
//  CPBSegmentedControl.h
//  ChargePhoneBill
//
//  Created by BoTao on 15/8/10.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

//#import <UIKit/UIKit.h>

typedef enum {
    CPBSegmentedControlSelectionStyleTextWidthStripe, // Indicator width will only be as big as the text width
    CPBSegmentedControlSelectionStyleFullWidthStripe, // Indicator width will fill the whole segment
    CPBSegmentedControlSelectionStyleBox, // A rectangle that covers the whole segment
    CPBSegmentedControlSelectionStyleArrow // An arrow in the middle of the segment pointing up or down depending on `CPBSegmentedControlSelectionIndicatorLocation`
} CPBSegmentedControlSelectionStyle;

typedef enum {
    CPBSegmentedControlSelectionIndicatorLocationUp,
    CPBSegmentedControlSelectionIndicatorLocationDown,
    CPBSegmentedControlSelectionIndicatorLocationNone // No selection indicator
} CPBSegmentedControlSelectionIndicatorLocation;

typedef enum {
    CPBSegmentedControlSegmentWidthStyleFixed, // Segment width is fixed
    CPBSegmentedControlSegmentWidthStyleDynamic, // Segment width will only be as big as the text width (including inset)
} CPBSegmentedControlSegmentWidthStyle;

enum {
    CPBSegmentedControlNoSegment = -1   // Segment index for no selected segment
};

typedef enum {
    CPBSegmentedControlTypeText,
    CPBSegmentedControlTypeImages,
    CPBSegmentedControlTypeTextImages
} CPBSegmentedControlType;

@interface EHISegmentedControl : UIControl

@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray *sectionImages;
@property (nonatomic, strong) NSArray *sectionSelectedImages;

/*
 Font for segments names when segmented control type is `CPBSegmentedControlTypeText`
 
 Default is [UIFont fontWithName:@"STHeitiSC-Light" size:18.0f]
 */
@property (nonatomic, strong) UIFont *font;

/*
 Text color for segments names when segmented control type is `CPBSegmentedControlTypeText`
 
 Default is [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor *textColor;

/*
 Text color for selected segment name when segmented control type is `CPBSegmentedControlTypeText`
 
 Default is [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor *selectedTextColor;

/*
 Segmented control background color.
 
 Default is [UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/*
 Color for the selection indicator stripe/box
 
 Default is R:52, G:181, B:229
 */
@property (nonatomic, strong) UIColor *selectionIndicatorColor;

/*
 Specifies the style of the control
 
 Default is `CPBSegmentedControlTypeText`
 */
@property (nonatomic, assign) CPBSegmentedControlType type;

/*
 Specifies the style of the selection indicator.
 
 Default is `CPBSegmentedControlSelectionStyleTextWidthStripe`
 */
@property (nonatomic, assign) CPBSegmentedControlSelectionStyle selectionStyle;

/*
 Specifies the style of the segment's width.
 
 Default is `CPBSegmentedControlSegmentWidthStyleFixed`
 */
@property (nonatomic, assign) CPBSegmentedControlSegmentWidthStyle segmentWidthStyle;

/*
 Specifies the location of the selection indicator.
 
 Default is `CPBSegmentedControlSelectionIndicatorLocationUp`
 */
@property (nonatomic, assign) CPBSegmentedControlSelectionIndicatorLocation selectionIndicatorLocation;

/*
 Default is NO. Set to YES to allow for adding more tabs than the screen width could fit.
 
 When set to YES, segment width will be automatically set to the width of the biggest segment's text or image,
 otherwise it will be equal to the width of the control's frame divided by the number of segments.
 
 As of v 1.4 this is no longer needed. The control will manage scrolling automatically based on tabs sizes.
 */
@property(nonatomic, getter = isScrollEnabled) BOOL scrollEnabled DEPRECATED_ATTRIBUTE;

/*
 Default is YES. Set to NO to deny scrolling by dragging the scrollView by the user.
 */
@property(nonatomic, getter = isUserDraggable) BOOL userDraggable;

/*
 Default is YES. Set to NO to deny any touch events by the user.
 */
@property(nonatomic, getter = isTouchEnabled) BOOL touchEnabled;


/*
 Index of the currently selected segment.
 */
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

/*
 Height of the selection indicator. Only effective when `CPBSegmentedControlSelectionStyle` is either `CPBSegmentedControlSelectionStyleTextWidthStripe` or `CPBSegmentedControlSelectionStyleFullWidthStripe`.
 
 Default is 5.0
 */
@property (nonatomic, readwrite) CGFloat selectionIndicatorHeight;

/*
 Inset left and right edges of segments. Only effective when `scrollEnabled` is set to YES.
 
 Default is UIEdgeInsetsMake(0, 5, 0, 5)
 */
@property (nonatomic, readwrite) UIEdgeInsets segmentEdgeInset;

/*
 Default is YES. Set to NO to disable animation during user selection.
 */
@property (nonatomic) BOOL shouldAnimateUserSelection;

- (id)initWithSectionTitles:(NSArray *)sectiontitles;
- (id)initWithSectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages;
- (instancetype)initWithSectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages titlesForSections:(NSArray *)sectiontitles;
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;

@end
