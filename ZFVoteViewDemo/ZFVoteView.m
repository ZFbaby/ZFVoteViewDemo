//
//  ZFVoteView.m
//  ZFVoteViewDemo
//
//  Created by MAC_PRO on 16/8/19.
//  Copyright © 2016年 ZFbory. All rights reserved.
//

#import "ZFVoteView.h"
#import "ZFConfig.h"
#import "ZFPercentBar.h"
#import "UIView+Extension.h"

@interface ZFVoteView ()

@property (nonatomic,weak) UILabel *voteLabel;

@property (nonatomic,weak) UILabel *percentLable;

@property (nonatomic,weak) UIImageView *thumbUpView;

@property (nonatomic,weak) ZFPercentBar *bar;
@end

@implementation ZFVoteView

-(instancetype)initWithFrame:(CGRect)frame voteView:(ZFVoteModel *)voteModel{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];

        self.layer.cornerRadius = ZFCornerRadius;
        
        self.layer.shadowOffset = CGSizeMake(-2.0, 0.0);
        
        self.layer.shadowRadius = 5.0;
        
        self.layer.shadowOpacity = 0.4;
        
        self.layer.masksToBounds = YES;
        
        [self initSubviews];
        
        self.voteModel = voteModel;
       
        if (self.voteModel) [self thumbUpstartAnimation];//有数据说明是要选中，给大拇指控件动画效果
        
    }
    return self;
}

-(void)initSubviews{

    ZFPercentBar *bar = [[ZFPercentBar alloc]initWithFrame:self.bounds];
    
    self.bar = bar;
    [self addSubview:bar];
    
    
    
    UIImageView *thumbUpView = [[UIImageView alloc]init];
    
    self.thumbUpView = thumbUpView;
    [self addSubview:thumbUpView];
    

    UILabel *percentLable = [UILabel labelWithFont:[UIFont systemFontOfSize:13.0]
                                         textColor:[UIColor lightGrayColor]
                                     textAlignment:NSTextAlignmentRight
                                     numberOfLines:1];
    
    self.percentLable = percentLable;
    [self addSubview:percentLable];
    

    UILabel *voteLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:15.0]
                                            textColor:[UIColor blackColor]
                                        textAlignment:NSTextAlignmentLeft
                                        numberOfLines:0];
    self.voteLabel = voteLabel;
    [self addSubview:voteLabel];
    
}



-(void)layoutSubviews{
    
    [super layoutSubviews];


    self.bar.frame = self.bounds;
    
    self.percentLable.x = ZFVoteTableViewMax_W - percentLable_W - thumbUpView_WH - 60;
    self.percentLable.y = 0;
    self.percentLable.width = percentLable_W;
    self.percentLable.height = self.height;
    
    
    self.thumbUpView.x = ZFVoteTableViewMax_W - thumbUpView_WH - 45;
    self.thumbUpView.width = thumbUpView_WH;
    self.thumbUpView.height = thumbUpView_WH;
    self.thumbUpView.centerY = self.height * 0.5;
    

    self.voteLabel.height = self.height;
    self.voteLabel.x = ZFVoteCellLeftRightInset;
    self.voteLabel.y = 0;
    self.voteLabel.width = self.width -(percentLable_W + thumbUpView_WH + 50);
    
}
- (void)thumbUpstartAnimation{
    
    self.thumbUpView.transform = CGAffineTransformIdentity;
    
    [UIView animateKeyframesWithDuration: 0.5 delay: 0 options: 0 animations: ^{

        [UIView addKeyframeWithRelativeStartTime: 0
                                relativeDuration: 1 / 3.0
                                      animations: ^{
                                          
                                          self.thumbUpView.transform = CGAffineTransformMakeScale(1.5, 1.5);
                                      }];
        [UIView addKeyframeWithRelativeStartTime: 1 / 3.0
                                relativeDuration: 1 / 3.0
                                      animations: ^{
                                          
                                          self.thumbUpView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                                      }];
        [UIView addKeyframeWithRelativeStartTime: 2 / 3.0
                                relativeDuration: 1 / 3.0
                                      animations: ^{
                                          
                                          self.thumbUpView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                      }];
    } completion: ^(BOOL finished) {
        
    }];
    
}


-(void)setVoteModel:(ZFVoteModel *)voteModel{
    
    _voteModel = voteModel;
    
    self.voteLabel.text = _voteModel.title;
    
    self.percentLable.text = [NSString stringWithFormat:@"%.f%%",([_voteModel.votes floatValue] / [_voteModel.totalVotes floatValue] * 100)];
    
    self.percentLable.textColor = _voteModel.isselected?ZFBlueColor:[UIColor lightGrayColor];
    
    self.thumbUpView.image = _voteModel.isselected?[UIImage imageNamed:@"Like-Blue"]:[UIImage imageNamed:@"Like-PlaceHold"];
    
    if (_voteModel.isvote) {//自己有投票

        self.bar.foregroundColor = _voteModel.isselected?ZFBlueColor:ZFlightBlueColor;
        
        self.bar.percentage = ([_voteModel.votes floatValue] / [_voteModel.totalVotes floatValue] * 100);

    }else{
        
        [self.bar reset];
    }

}

@end

