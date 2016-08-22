//
//  ZFVoteCell.m
//  ZFVoteViewDemo
//
//  Created by MAC_PRO on 16/8/18.
//  Copyright © 2016年 ZFbory. All rights reserved.
//

#import "ZFVoteCell.h"
#import "ZFConfig.h"
#import "UIView+Extension.h"
#import "ZFVoteView.h"

@interface ZFVoteCell ()

@property (nonatomic,weak) ZFVoteView *voteView;

@end

@implementation ZFVoteCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = ZFCornerRadius;
        self.layer.masksToBounds = YES;
        
        
        [self setupVoteView];//初始化投票主控件

    }
    return self;
}

-(void)setupVoteView{
    
    ZFVoteView *voteView = [[ZFVoteView alloc]initWithFrame:self.bounds
                                                   voteView:nil];
    self.voteView = voteView;
    
    [self addSubview:voteView];
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    self.voteView.frame = self.bounds;
}


-(void)setVoteModel:(ZFVoteModel *)voteModel{

    _voteModel = voteModel;
    
    self.voteView.voteModel = _voteModel;
    
}

-(void)thumbUpstartAnimation{
    
    [self.voteView thumbUpstartAnimation];
    
}

-(void)setFrame:(CGRect)frame{
    
        if (frame.size.width == ZFVoteTableViewMax_W) {//初始化就设置cell的内边距
            
            frame = UIEdgeInsetsInsetRect(frame,
                                          UIEdgeInsetsMake(ZFVoteCellTopBottomInset,
                                                           ZFVoteCellLeftRightInset,
                                                           ZFVoteCellTopBottomInset,
                                                           ZFVoteCellLeftRightInset));
        }else{//重复利用的时候改变它的x值
            
            frame.origin.x += ZFVoteCellLeftRightInset;
        }
    [super setFrame:frame];
}



@end
