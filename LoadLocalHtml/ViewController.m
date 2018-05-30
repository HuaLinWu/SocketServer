//
//  ViewController.m
//  LoadLocalHtml
//
//  Created by 吴华林 on 2018/5/30.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)startLoadAction:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/index.html"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"timg" ofType:@"jpeg"];
//    NSData *data = [NSData dataWithContentsOfFile:imagePath];
//    [urlRequest setHTTPBody:data];
    
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
