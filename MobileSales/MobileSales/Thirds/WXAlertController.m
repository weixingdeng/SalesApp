//
//  WXAlertController.m
//
//  Created by wxdeng on 15/12/29.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "WXAlertController.h"
#import <objc/runtime.h>

#pragma mark - const values

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kContainerLeft ((kScreenWidth - self.sheetWidth)/2)

#define kiOS7Later SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define kiOS8Later SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define kiOS9Later SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
#define kiOS10Later SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
@interface UIViewController (WXAlertController)
@property (nonatomic,strong,nullable) WXAlertController *wxAlertController;
@end

@implementation UIViewController (WXAlertController)

@dynamic wxAlertController;

#pragma mark - AssociatedObject

- (WXAlertController *)wxAlertController
{
    return objc_getAssociatedObject(self, @selector(wxAlertController));
}

- (void)setTbAlertController:(WXAlertController *)wxAlertController
{
    objc_setAssociatedObject(self, @selector(wxAlertController), wxAlertController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class aClass = [self class];
        
        SEL originalSelector = @selector(presentViewController:animated:completion:);
        SEL swizzledSelector = @selector(wx_presentViewController:animated:completion:);
        
        Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(aClass,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(aClass,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

- (void)wx_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    if ([viewControllerToPresent isKindOfClass:[WXAlertController class]]) {
        WXAlertController* controller = (WXAlertController *)viewControllerToPresent;
        if (kiOS8Later) {
            ((UIAlertController *)controller.adaptiveAlert).view.tintColor = controller.tintColor;
            [self wx_presentViewController:((WXAlertController *)viewControllerToPresent).adaptiveAlert animated:flag completion:completion];
        }
        else {
            if ([controller.adaptiveAlert isKindOfClass:[UIAlertView class]]) {
                self.wxAlertController = controller;
                controller.ownerController = self;
                [controller.textFieldHandlers enumerateObjectsUsingBlock:^(void (^configurationHandler)(UITextField *textField), NSUInteger idx, BOOL *stop) {
                    configurationHandler([controller.adaptiveAlert textFieldAtIndex:idx]);
                }];
                [controller.adaptiveAlert show];
            }
            else if ([controller.adaptiveAlert isKindOfClass:[UIActionSheet class]]) {
                self.wxAlertController = controller;
                controller.ownerController = self;
                [controller.adaptiveAlert showInView:self.view];
            }
        }
    }
    else {
        [self wx_presentViewController:viewControllerToPresent animated:flag completion:completion];
    }
}

@end

@interface WXAlertAction ()
@property (nullable, nonatomic, readwrite) NSString *title;
@property (nonatomic,readwrite) WXAlertActionStyle style;
@property (nullable,nonatomic,strong,readwrite) void (^handler)(WXAlertAction *);
@end

@implementation WXAlertAction
+ (id)actionWithTitle:(NSString *)title style:(WXAlertActionStyle)style handler:(void (^)(WXAlertAction *))handler
{
    if (kiOS8Later) {
        UIAlertActionStyle actionStyle = (NSInteger)style;
        return [UIAlertAction actionWithTitle:title style:actionStyle handler:(void (^)(UIAlertAction *))handler];
    }
    else {
        WXAlertAction *action = [[WXAlertAction alloc] init];
        action.title = [title copy];
        action.style = style;
        action.handler = handler;
        action.enabled = YES;
        return action;
    }
}

@end

@interface WXAlertController() <UIActionSheetDelegate, UIAlertViewDelegate>
@property (nonnull,nonatomic,strong,readwrite) id adaptiveAlert;

@property (nonnull,nonatomic, readwrite) NSMutableArray<WXAlertAction *> *mutableActions;
@property (nonnull,nonatomic, readwrite) NSArray<WXAlertAction *> *actions;

@property (nullable, nonatomic, copy, readwrite) NSArray< void (^)(UITextField *textField)> *textFieldHandlers;

@property (nonatomic, readwrite) WXAlertControllerStyle preferredStyle;
@end

@implementation WXAlertController

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (kiOS8Later) {
            _adaptiveAlert = [[UIAlertController alloc] init];
        }
        else {
            _adaptiveAlert = [[UIActionSheet alloc] init];
            _mutableActions = [NSMutableArray array];
            _textFieldHandlers = @[];
            _preferredStyle = WXAlertControllerStyleActionSheet;
            ((UIActionSheet *)_adaptiveAlert).delegate = self;
        }
        [self addObserver:self forKeyPath:@"view.tintColor" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"view.tintColor"];
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(WXAlertControllerStyle)preferredStyle
{
    WXAlertController *controller = [[WXAlertController alloc] init];
    controller.preferredStyle = preferredStyle;
    if (kiOS8Later) {
        controller.adaptiveAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(NSInteger)preferredStyle];
    }
    else {
        switch (preferredStyle) {
            case WXAlertControllerStyleActionSheet: {
                controller.adaptiveAlert = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"%@\n%@",title,message] delegate:controller cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
                break;
            }
            case WXAlertControllerStyleAlert: {
                controller.adaptiveAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:controller cancelButtonTitle:nil otherButtonTitles: nil];
                break;
            }
            default: {
                break;
            }
        }
    }
    return controller;
}

#pragma mark - getter&setter

- (NSArray<WXAlertAction *> *)actions
{
    return [self.mutableActions copy];
}

- (NSArray<UITextField *> *)textFields
{
    if (kiOS8Later) {
        return ((UIAlertController *)self.adaptiveAlert).textFields;
    }
    else {
        if ([self.adaptiveAlert isKindOfClass:[UIAlertView class]]) {
            switch (((UIAlertView *)self.adaptiveAlert).alertViewStyle) {
                case UIAlertViewStyleDefault: {
                    return @[];
                    break;
                }
                case UIAlertViewStyleSecureTextInput: {
                    return @[[((UIAlertView *)self.adaptiveAlert) textFieldAtIndex:0]];
                    break;
                }
                case UIAlertViewStylePlainTextInput: {
                    return @[[((UIAlertView *)self.adaptiveAlert) textFieldAtIndex:0]];
                    break;
                }
                case UIAlertViewStyleLoginAndPasswordInput: {
                    return @[[((UIAlertView *)self.adaptiveAlert) textFieldAtIndex:0], [((UIAlertView *)self.adaptiveAlert) textFieldAtIndex:1]];
                    break;
                }
                default: {
                    break;
                }
            }
        }
        else {
            return nil;
        }
    }
}

- (NSString *)title
{
    return [self.adaptiveAlert title];
}

- (void)setTitle:(NSString *)title
{
    [self.adaptiveAlert setTitle:title];
}

- (NSString *)message
{
    return [self.adaptiveAlert message];
}

- (void)setMessage:(NSString *)message
{
    [self.adaptiveAlert setMessage:message];
}

- (UIAlertViewStyle)alertViewStyle
{
    if (!kiOS8Later&&[self.adaptiveAlert isKindOfClass:[UIAlertView class]]) {
        return [self.adaptiveAlert alertViewStyle];
    }
    return 0;
}

- (void)setAlertViewStyle:(UIAlertViewStyle)alertViewStyle
{
    if (!kiOS8Later&&[self.adaptiveAlert isKindOfClass:[UIAlertView class]]) {
        [self.adaptiveAlert setAlertViewStyle:alertViewStyle];
    }
}

- (WXAlertAction *)preferredAction
{
    if (kiOS9Later) {
        return (WXAlertAction *)[self.adaptiveAlert preferredAction];
    }
    return nil;
}

- (void)setPreferredAction:(WXAlertAction *)preferredAction
{
    if (kiOS9Later) {
        [self.adaptiveAlert setPreferredAction:preferredAction];
    }
}

- (void)addAction:(WXAlertAction *)action
{
    if (kiOS8Later) {
        [self.adaptiveAlert addAction:(UIAlertAction *)action];
    }
    else {
        [self.mutableActions addObject:action];
        
        NSInteger buttonIndex = [self.adaptiveAlert addButtonWithTitle:action.title];
        UIColor *textColor;
        switch (action.style) {
            case WXAlertActionStyleDefault: {
                textColor = self.tintColor;
                break;
            }
            case WXAlertActionStyleCancel: {
                [self.adaptiveAlert setCancelButtonIndex:buttonIndex];
                textColor = self.tintColor;
                break;
            }
            case WXAlertActionStyleDestructive: {
                [self.adaptiveAlert setDestructiveButtonIndex:buttonIndex];
                textColor = [UIColor redColor];
                break;
            }
            default: {
                textColor = self.tintColor;
                break;
            }
        }
        //        [((UIButton *)((UIView *)self.adaptiveAlert).subviews.lastObject) setTitleColor:textColor forState:0xFFFFFFFF];
    }
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField * _Nonnull))configurationHandler
{
    if (kiOS8Later) {
        [self.adaptiveAlert addTextFieldWithConfigurationHandler:configurationHandler];
    }
    else {
        if ([self.adaptiveAlert isKindOfClass:[UIAlertView class]]) {
            //TODO: UIAlertView 靠样式来添加 TextField，建议直接使用 iOS7CustomAlertView
            self.textFieldHandlers = [[NSArray arrayWithArray:self.textFieldHandlers] arrayByAddingObject:configurationHandler ?: ^(UITextField *textField){}];
            ((UIAlertView *)self.adaptiveAlert).alertViewStyle = self.textFieldHandlers.count > 1 ? UIAlertViewStyleLoginAndPasswordInput : UIAlertViewStylePlainTextInput;
        }
    }
}

#pragma mark - WXActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __weak __typeof(WXAlertAction *)weakAction = self.mutableActions[buttonIndex];
    if (self.mutableActions[buttonIndex].handler) {
        self.mutableActions[buttonIndex].handler(weakAction);
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.ownerController.wxAlertController = nil;
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    self.ownerController.wxAlertController = nil;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __weak __typeof(WXAlertAction *)weakAction = self.mutableActions[buttonIndex];
    if (self.mutableActions[buttonIndex].handler) {
        self.mutableActions[buttonIndex].handler(weakAction);
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.ownerController.wxAlertController = nil;
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    self.ownerController.wxAlertController = nil;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"view.tintColor"]) {
        self.tintColor = change[NSKeyValueChangeNewKey];
    }
}
@end
