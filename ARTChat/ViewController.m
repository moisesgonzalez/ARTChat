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

- (IBAction)connect:(UIButton *)sender
{
    sender.enabled = NO;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self connectToServer:self.serverAddressField.text];
    });
}

#pragma mark - Socket communications

- (void)connectToServer:(NSString *)serverAddress
{
    // Get address information
    struct addrinfo hints, *res;

    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;

    getaddrinfo([serverAddress UTF8String], "8081", &hints, &res);

    // Create socket and connect
    self.socketFD = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    connect(self.socketFD, res->ai_addr, res->ai_addrlen);

    fcntl(self.socketFD, F_SETFL, O_NONBLOCK);

    // Create dispatch source for socket
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_TARGET_QUEUE_DEFAULT, 0);
    self.socketSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, self.socketFD, 0, queue);

    dispatch_source_set_event_handler(self.socketSource, ^{
        [self readFromSocket:self.socketSource socket:self.socketFD];
    });

    dispatch_source_set_cancel_handler(self.socketSource, ^{
        NSLog(@"Canceled");
        close(self.socketFD);

    });

    dispatch_resume(self.socketSource);

}

//#error readFromSocket needs some implementation
- (void)readFromSocket:(dispatch_source_t)readSource socket:(int)socket{
    //size_t estimated = dispatch_source_get_data(readSource) + 1;
    //char* buffer = (char*)malloc(estimated);
    unsigned int length = 0;
    char* buffer = 0;
    ReadXBytes(socket, sizeof(length), (void*)(&length));
     buffer =  (char*)malloc(length);
    ReadXBytes(socket, length, (void*)buffer);
     NSLog(@"%s", buffer);
    free(buffer);

}
void ReadXBytes(int socket, unsigned int x, void* buffer)
{
    int bytesRead = 0;
    
    int result;
    while (bytesRead < x)
    {
        //result =(int)read(socket, buffer + bytesRead, x - bytesRead);
    result =(int)read(socket, buffer + bytesRead, x - bytesRead);
       
        if (result < 1 )
        {
            // Throw your error.
        }
        
        bytesRead += result;
    }
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
