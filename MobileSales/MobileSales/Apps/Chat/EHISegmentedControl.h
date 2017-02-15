//
//  EHISegmentedControl.h
//  MobileSales
//
//  Created by dengwx on 2017/2/15.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHISegmentedControl : UIControl

@property (nonatomic, strong) NSArray *sectionTitles;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIColor *selectedTextColor;

@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, strong) UIColor *selectionIndicatorColor;

@property (nonatomic, assign) NSInteger selectedSegmentIndex;

@property (nonatomic, readwrite) CGFloat selectionIndicatorHeight;

- (id)initWithSectionTitles:(NSArray *)sectiontitles;

@end
