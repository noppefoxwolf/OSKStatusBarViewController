//
//  OSKStatusBarViewController.m
//  OSKStatusBar
//
//  Created by Tomoya_Hirano on 5/23/15.
//  Copyright (c) 2015 Tomoya_Hirano. All rights reserved.
//

#import "OSKStatusBarViewController.h"

@interface OSKStatusBarViewController (){
    UIWindow *goastStatusBar;
    UIImageView*goastImageView;
    UIWindow *statusbarBack;
}
@end

@implementation OSKStatusBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    statusbarBack = [[UIWindow alloc] initWithFrame:[[UIApplication sharedApplication] statusBarFrame]];
    statusbarBack.backgroundColor = [UIColor clearColor];
    statusbarBack.windowLevel = UIWindowLevelStatusBar-1;
    [statusbarBack makeKeyAndVisible];
    
    goastStatusBar = [[UIWindow alloc] initWithFrame:[[UIApplication sharedApplication] statusBarFrame]];
    goastImageView = [[UIImageView alloc] initWithFrame:goastStatusBar.bounds];
    [goastStatusBar addSubview:goastImageView];
    goastStatusBar.backgroundColor = [UIColor clearColor];
    goastStatusBar.windowLevel = UIWindowLevelStatusBar+1;
    [goastStatusBar makeKeyAndVisible];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self refreshStatusBar];
}

- (void)refreshStatusBar{
    goastImageView.image = [self tintStatusBarImageWithColor:self.statusBarColor];
}

- (void)viewDidDisappear:(BOOL)animated{
    [statusbarBack removeFromSuperview];
    [goastStatusBar removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Utility

//UIColorから塗られたUIImageを取得
- (UIImage *)tintStatusBarImageWithColor:(UIColor*)color{
    UIImage *image = [self imageWithColor:color];
    UIImage *maskImage = [self statusBarImage];
    CGImageRef maskImageRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskImageRef),
                                        CGImageGetHeight(maskImageRef),
                                        CGImageGetBitsPerComponent(maskImageRef),
                                        CGImageGetBitsPerPixel(maskImageRef),
                                        CGImageGetBytesPerRow(maskImageRef),
                                        CGImageGetDataProvider(maskImageRef), NULL, NO); //マスクを作成
    CGImageRef masked = CGImageCreateWithMask(image.CGImage, mask); //マスクの形に切り抜く
    UIImage *maskedImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(mask);
    CGImageRelease(masked);
    return maskedImage;
}

//UIColorからUIImageを生成
- (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = [[UIApplication sharedApplication] statusBarFrame];
    UIGraphicsBeginImageContextWithOptions(rect.size , true ,[UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//ステータスバーのUIImageを取得
- (UIImage *)statusBarImage{
    goastImageView.image = nil;
    statusbarBack.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    UIView*view = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:true];
    [[UIApplication sharedApplication] setStatusBarHidden:true];
    CGSize size = [[UIApplication sharedApplication] statusBarFrame].size;
    UIImage *capture;
    UIGraphicsBeginImageContextWithOptions(size , true ,[UIScreen mainScreen].scale);
    
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    } else {
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    capture = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    statusbarBack.backgroundColor = [UIColor clearColor];
    return capture;
}
@end
