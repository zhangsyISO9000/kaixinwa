//
//  QKMessageView.m
//  kaixinwa
//
//  Created by 张思源 on 15/9/6.
//  Copyright (c) 2015年 乾坤翰林. All rights reserved.
//

#import "QKMessageView.h"
#import "QKMessageContent.h"

@interface QKMessageView()
@property(nonatomic,weak)UIButton * typeBtn;
@property(nonatomic,weak)UILabel * titleLabel;
@property(nonatomic,weak)UILabel * detailLabel;
@property(nonatomic,weak)UIView * line;
@property(nonatomic,weak)UILabel * timeLabel;
@end

@implementation QKMessageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIButton * typeBtn = [[UIButton alloc]init];
        
        [typeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        typeBtn.userInteractionEnabled = NO;
        [self addSubview:typeBtn];
        self.typeBtn = typeBtn;
        
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        //创建时间标签
        UILabel * timeLabel = [[UILabel alloc]init];
        timeLabel.font = titleLabel.font;
        timeLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel * detailLabel = [[UILabel alloc]init];
        detailLabel.font = [UIFont systemFontOfSize:12];
        detailLabel.textColor = [UIColor lightGrayColor];
        detailLabel.numberOfLines = 0;
        [self addSubview:detailLabel];
        self.detailLabel = detailLabel;
        
        UIView * line = [[UIView alloc]init];
        line.backgroundColor = QKColor(240, 240, 240);
        [self addSubview:line];
        self.line = line;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.typeBtn.x = QKCellMargin;
    self.typeBtn.y = QKCellMargin;
    self.typeBtn.width = 60;
    self.typeBtn.height = 25;
    
    self.titleLabel.x = self.typeBtn.x + self.typeBtn.width + 2 * QKCellMargin;
    
    CGSize titleLabelSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    self.titleLabel.size = titleLabelSize;
    self.titleLabel.centerY = self.typeBtn.centerY;
    
    CGSize timeLabelSize = [self.timeLabel.text sizeWithAttributes:@{NSFontAttributeName : self.timeLabel.font}];
    self.timeLabel.size = timeLabelSize;
    self.timeLabel.x = CGRectGetMaxX(self.titleLabel.frame) + QKCellMargin;
    self.timeLabel.y = self.titleLabel.y;
    
    
    self.line.x = QKCellMargin;
    self.line.y = self.typeBtn.height + QKCellMargin * 2;
    self.line.size = CGSizeMake(QKScreenWidth - QKCellMargin, 1);
    
    self.detailLabel.x = QKCellMargin;
    self.detailLabel.y = CGRectGetMaxY(self.line.frame) + QKCellMargin;
    self.detailLabel.size = [self.detailLabel.text sizeWithAttributes:@{NSFontAttributeName : self.detailLabel.font}];
    
    self.size = CGSizeMake(QKScreenWidth, CGRectGetMaxY(self.detailLabel.frame)+QKCellMargin);
}
-(void)setMessageContent:(QKMessageContent *)messageContent
{
    _messageContent = messageContent;
    
    self.titleLabel.text = messageContent.title;
    if([messageContent.title containsString:@"签到"]){
        [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"green-frame"] forState:UIControlStateNormal];
        [self.typeBtn setTitle:@"消息" forState:UIControlStateNormal];
    }else{
        [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"yellow-frame"] forState:UIControlStateNormal];
        [self.typeBtn setTitle:@"消息" forState:UIControlStateNormal];
    }
    
    self.detailLabel.text = messageContent.detailText;
    self.timeLabel.text = messageContent.timeStr;
}
@end
