//
//  XGAreaPickerView.h
//  FNMarket
//
//  Created by Yuen on 10/15/15.
//  Copyright © 2015 Yuen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XGAreaPickerView;
@protocol XGAreaPickerViewDelegate <NSObject>

- (void)didClickConfirmButtonInAreaPickerView:(XGAreaPickerView *)pickerView provinceString:(NSString *)provinceInfo;
//- (void)didClickCancelButtonInAreaPickerView:(XGAreaPickerView *)pickerView;

@end

@interface XGAreaPickerView : UIView

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, weak) id <XGAreaPickerViewDelegate> delegate;

@end
