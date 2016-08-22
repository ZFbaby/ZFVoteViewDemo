//
//  ZFPercentBar.h
//  ZFVoteViewDemo
//
//  Created by MAC_PRO on 16/8/18.
//  Copyright © 2016年 ZFbory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFPercentBar : UIView


@property (nonatomic, assign) CGFloat percentage;

@property (nonatomic, strong) UIColor *foregroundColor;

- (void)reset;

@end
