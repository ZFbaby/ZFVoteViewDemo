//
//  ViewController.m
//  ZFVoteViewDemo
//
//  Created by MAC_PRO on 16/8/18.
//  Copyright © 2016年 ZFbory. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "ZFVoteModel.h"
#import "ZFVoteCell.h"
#import "ZFConfig.h"
#import "UIView+Extension.h"
#import "ZFVoteView.h"
#import "ZFVoteTableView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *list;

@property (nonatomic,weak) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self loadNewData];
    
    [self setupTableView];
    
}

-(NSMutableArray *)list{

    if (!_list) {
        
        _list = [NSMutableArray array];
    }
    return _list;
}
-(void)loadNewData{

    //模拟延迟加载
    typeof(self) weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"abc.plist" ofType:nil];
        
        NSDictionary *votesDic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        weakSelf.list = [ZFVoteModel mj_objectArrayWithKeyValuesArray:votesDic[@"data"][@"list"]];
        
        [weakSelf.tableView reloadData];
   
    });
    
}
-(void)setupTableView{


    ZFVoteTableView *tableVew = [[ZFVoteTableView alloc]initWithFrame:CGRectMake(20,
                                                                                 100,
                                                                                 ZFVoteTableViewMax_W,
                                                                                 400)//这里最好是得到数据算出的总高度
                                                                style:UITableViewStylePlain];
    
    tableVew.delegate = self;
    tableVew.dataSource = self;
    self.tableView = tableVew;
    [self.view addSubview:tableVew];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.list.count;
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ZFVoteModel *voteModel = self.list[indexPath.row];
    
    static NSString *ZFVoteCellIdentifier = @"ZFVoteCellIdentifier";
    
    ZFVoteCell *cell = [tableView dequeueReusableCellWithIdentifier:ZFVoteCellIdentifier];
    
    if (!cell) {
        
        cell = [[ZFVoteCell alloc]initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:ZFVoteCellIdentifier];
    }
    
    cell.voteModel = voteModel;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZFVoteModel *voteModel = self.list[indexPath.row];
    
    return voteModel.voteCell_H;
    
}
#pragma mark - 核心动画效果实现步骤
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self refreshDataAtIndexPath:indexPath];//刷新数据
    
    
    ZFVoteModel *voteModel = self.list[indexPath.row];
    
    ZFVoteCell *selectedCell = [_tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0) {
        [selectedCell thumbUpstartAnimation];
        return;
    }

    ZFVoteView *voteView = [[ZFVoteView alloc]initWithFrame:selectedCell.frame
                                                   voteView:voteModel];
    voteView.layer.masksToBounds = NO;
    [self.tableView addSubview:voteView];
    self.tableView.userInteractionEnabled = NO;


    [UIView animateWithDuration:0.4
                     animations:^{

                      voteView.transform = CGAffineTransformMakeScale(1.05, 1.05);
        
                     }completion:^(BOOL finished) {
        
                        [UIView animateWithDuration:0.7
                                         animations:^{

                                            [self.list removeObject:voteModel];
                                            [self.list insertObject:voteModel atIndex:0];
                                            [self.tableView moveRowAtIndexPath:indexPath
                                                                   toIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                                            voteView.centerY = selectedCell.centerY;
                                            voteView.centerX = selectedCell.centerX;
                                            
                                        }completion:^(BOOL finished) {
                                           
                                            [UIView animateWithDuration:0.4
                                                             animations:^{
                                                                
                                                                voteView.transform = CGAffineTransformIdentity;

                                                            }completion:^(BOOL finished) {
                                                               
                                                                [voteView removeFromSuperview];
                                                                self.tableView.userInteractionEnabled = YES;

                                                            }];
                        }];
    }];
    
}

#pragma mark - 模拟刷新数据
-(void)refreshDataAtIndexPath:(NSIndexPath *)indexPath{
    
    ZFVoteModel *voteModel = self.list[indexPath.row];
    
    [self.list enumerateObjectsUsingBlock:^(ZFVoteModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (voteModel.isselected) {//说明是取消选中
            obj.isvote = NO;
            if (obj == voteModel) {
                obj.votes = @([obj.votes integerValue] - 40);
            }
            obj.totalVotes = @([obj.totalVotes integerValue] - 40);
        }else{
            if (obj.isselected) {
                obj.votes = @([obj.votes integerValue] - 40);
            }
            if (obj == voteModel ) {
                obj.votes = @([obj.votes integerValue] + 40);
            }
            if (!obj.isvote) {
                obj.totalVotes = @([obj.totalVotes integerValue] + 40);
            }
            
            obj.isvote = YES;
        }
        if (voteModel != obj) {
            
            obj.isselected = NO;
        }
    }];
    
    voteModel.isselected = !voteModel.isselected;
    
    [self.tableView reloadData];
    
}

@end
