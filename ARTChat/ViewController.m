//
//  ViewController.m
//  ARTChat
//
//  Created by Grimi on 8/21/15.
//  Copyright (c) 2015 Grimi. All rights reserved.
//

#import "ViewController.h"

#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>

@interface ViewController ()

@property (assign, nonatomic) int                socketFD;
@property (strong, nonatomic) dispatch_source_t socketSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];

    return cell;
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

@end
