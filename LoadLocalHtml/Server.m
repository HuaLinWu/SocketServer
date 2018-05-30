//
//  Server.m
//  LoadLocalHtml
//
//  Created by 吴华林 on 2018/5/30.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "Server.h"
#import "GCDAsyncSocket.h"
@interface Server()<GCDAsyncSocketDelegate>
@property(nonatomic,strong)GCDAsyncSocket *serverSocket;
@property(nonatomic,strong)dispatch_queue_t delegateQueue;
@property(nonatomic,strong)dispatch_queue_t socketQueue;
@property(nonatomic,strong)NSMutableArray *clientSockets;
@end
@implementation Server
- (void)startServer {
    self.delegateQueue = dispatch_queue_create("serverSocketDelegateQueue", DISPATCH_QUEUE_CONCURRENT);
    self.socketQueue = dispatch_queue_create("serverSocketQueue", DISPATCH_QUEUE_CONCURRENT);
    self.serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:self.delegateQueue socketQueue:self.socketQueue];
    NSError *error;
    [self.serverSocket acceptOnInterface:@"127.0.0.1" port:8080 error:&error];
    if (error) {
        NSLog(@"开启监听失败 : %@",error);
    }else{
        NSLog(@"开启监听成功");
    }
}
#pragma mark GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    //存放客户端的socket对象。
    [self.clientSockets addObject:newSocket];
    [newSocket readDataWithTimeout:-1 tag:0];
    NSLog(@"---建立连接成功-->");
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    //每当有客户端断开连接的时候，客户端数组移除该socket
    [self.clientSockets removeObject:sock];
     NSLog(@"----断开连接-->");
}
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    //持续读取服务端输入的数据
    [sock readDataWithTimeout:-1 tag:tag];
    NSString *str  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"----接受到的数据-->%@",str);
    NSString *indexHtmlPath = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
    NSData *htmlData = [NSData dataWithContentsOfFile:indexHtmlPath];
    [sock writeData:htmlData withTimeout:-1 tag:tag];
    
    
}
#pragma mark set/get
- (NSMutableArray *)clientSockets {
    if(!_clientSockets) {
        _clientSockets = [[NSMutableArray alloc] init];
    }
    return _clientSockets;
}
@end
