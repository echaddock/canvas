//
//  CanvasViewController.m
//  Canvas
//
//  Created by Liz Chaddock on 9/17/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()
@property (weak, nonatomic) IBOutlet UIView *trayView;
@property CGPoint trayOriginalCenter;
@property float up;
@property float down;
@property (strong, nonatomic) UIImageView *newlyCreatedFace;

@end

@implementation CanvasViewController
- (IBAction)onTrayPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender translationInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        _trayOriginalCenter = _trayView.center;
    } else if (sender.state == UIGestureRecognizerStateChanged) {

        _trayView.center = CGPointMake(_trayOriginalCenter.x,  _trayOriginalCenter.y + point.y);
    } else {
        //released
        CGPoint velocity = [sender velocityInView:self.view];
        if (velocity.y > 0) {
            //moving down
            _trayView.center = CGPointMake(_trayOriginalCenter.x, self.down);
        } else {
            _trayView.center = CGPointMake(_trayOriginalCenter.x, self.up);
        }
    }
    
}
- (IBAction)selectedSmiley:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.view];

    if (sender.state == UIGestureRecognizerStateBegan) {
        UIImageView *imageView = (UIImageView *)sender.view;
        _newlyCreatedFace = [[UIImageView alloc] initWithImage:imageView.image];
        [self.view addSubview:_newlyCreatedFace];
        _newlyCreatedFace.center = CGPointMake(imageView.center.x, point.y + _trayView.frame.origin.y);
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        _newlyCreatedFace.center = CGPointMake(point.x, point.y);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.up = 480;
    self.down = 629;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
