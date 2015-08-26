//
//  ViewController.h
//  ARTChat
//
//  Created by Grimi on 8/21/15.
//  Copyright (c) 2015 Grimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *serverAddressField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

