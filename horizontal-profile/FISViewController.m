//
//  FISViewController.m
//  horizontal-profile
//
//  Created by Matt Amerige on 6/27/16.
//  Copyright © 2016 The Flatiron School. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestingFactLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) NSLayoutConstraint *profilePicturePortraitTopAnchorConstraint;
@property (strong, nonatomic) NSLayoutConstraint *profilePictureLandscapeTopAnchorConstraint;

@property (strong, nonatomic) NSLayoutConstraint *coverImageTopAnchorConstraint;
@property (strong, nonatomic) NSLayoutConstraint *coverImageWidthAnchorConstraint;
@property (strong, nonatomic) NSLayoutConstraint *coverImageHeightAnchorConstraint;

@property (strong, nonatomic) NSLayoutConstraint *textViewLeftAnchor6PlusLandscapeConstraint;
@property (strong, nonatomic) NSLayoutConstraint *textViewLeftAnchorPortraitConstraint;

@property (strong, nonatomic) NSLayoutConstraint *textViewTopAnchor6PlusLandscapeConstraint;
@property (strong, nonatomic) NSLayoutConstraint *textViewTopAnchorConstraint;



@end

@implementation FISViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
    // Remove for the view
    [self removeAllContraints];
    [self applyStandardConstraints];
}

- (void)removeAllContraints
{
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view removeConstraints:self.view.constraints];
	// remove for all subviews
	for (UIView *subview in self.view.subviews) {
		subview.translatesAutoresizingMaskIntoConstraints = NO;
		[subview removeConstraints:subview.constraints];
	}
}

- (void)applyStandardConstraints
{
	// cover image
	self.coverImageTopAnchorConstraint = [self.coverImageView.topAnchor constraintEqualToAnchor:self.view.topAnchor];
	self.coverImageWidthAnchorConstraint = [self.coverImageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor];
	self.coverImageHeightAnchorConstraint = [self.coverImageView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.25];
    self.coverImageTopAnchorConstraint.active = YES;
    self.coverImageHeightAnchorConstraint.active = YES;
    self.coverImageWidthAnchorConstraint.active = YES;
    
    
    // Profile pic
    [self.profilePictureImageView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
    self.profilePicturePortraitTopAnchorConstraint = [self.profilePictureImageView.topAnchor constraintEqualToAnchor:self.coverImageView.bottomAnchor constant:20];
    self.profilePicturePortraitTopAnchorConstraint.active = YES;
    
    // Used for profile picture during landscape
    self.profilePictureLandscapeTopAnchorConstraint = [self.profilePictureImageView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20];
    
    
    // Name Label
    [self.nameLabel.leftAnchor constraintEqualToAnchor:self.profilePictureImageView.rightAnchor constant:10].active = YES;
    [self.nameLabel.topAnchor constraintEqualToAnchor:self.profilePictureImageView.topAnchor constant:0].active = YES;
    
    // Class name label
    [self.classNameLabel.leftAnchor constraintEqualToAnchor:self.profilePictureImageView.rightAnchor constant:10].active = YES;
    [self.classNameLabel.centerYAnchor constraintEqualToAnchor:self.profilePictureImageView.centerYAnchor constant:0].active = YES;
    
    // Interesting fact label
    [self.interestingFactLabel.leftAnchor constraintEqualToAnchor:self.profilePictureImageView.rightAnchor constant:10].active = YES;
    [self.interestingFactLabel.bottomAnchor constraintEqualToAnchor:self.profilePictureImageView.bottomAnchor constant:0].active = YES;
    
    // Text view
    self.textViewTopAnchorConstraint = [self.textView.topAnchor constraintEqualToAnchor:self.profilePictureImageView.bottomAnchor constant:10];
    self.textViewLeftAnchorPortraitConstraint =[self.textView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:10];
    self.textViewTopAnchorConstraint.active = YES;
    self.textViewLeftAnchorPortraitConstraint.active = YES;
    
    // Used on iPhone 6+ in landscape
    self.textViewTopAnchor6PlusLandscapeConstraint = [self.textView.topAnchor constraintEqualToAnchor:self.nameLabel.topAnchor];
    self.textViewLeftAnchor6PlusLandscapeConstraint = [self.textView.leftAnchor constraintEqualToAnchor:self.interestingFactLabel.rightAnchor constant:10];
    
    
    [self.textView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-10].active = YES;
    [self.textView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-10].active = YES;
}

- (void)activateCoverImageConstraints:(BOOL)activate
{
    self.coverImageTopAnchorConstraint.active = activate;
    self.coverImageHeightAnchorConstraint.active = activate;
    self.coverImageWidthAnchorConstraint.active = activate;
}

- (void)activateiPhone6PlusLandscapeLayout:(BOOL)shouldActivate
{
    if (shouldActivate) {
        self.textViewTopAnchorConstraint.active = NO;
        self.textViewLeftAnchorPortraitConstraint.active = NO;
        
        self.textViewTopAnchor6PlusLandscapeConstraint.active = YES;
        self.textViewLeftAnchor6PlusLandscapeConstraint.active = YES;
    }
    else {
        self.textViewTopAnchor6PlusLandscapeConstraint.active = NO;
        self.textViewLeftAnchor6PlusLandscapeConstraint.active = NO;
        
        self.textViewTopAnchorConstraint.active = YES;
        self.textViewLeftAnchorPortraitConstraint.active = YES;
    }
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [self changeLayoutForTraitCollection:newCollection];
}

- (void)changeLayoutForTraitCollection:(UITraitCollection *)collection
{
    
    if (collection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        
        if (collection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
            // iphone 6+ landscape
            // Move the textview to the right of all the labels
            [self activateiPhone6PlusLandscapeLayout:YES];
            [self activateCoverImageConstraints:YES];
        }
        else {
            self.coverImageView.hidden = YES;
            self.profilePicturePortraitTopAnchorConstraint.active = NO;
            self.profilePictureLandscapeTopAnchorConstraint.active = YES;
            [self activateCoverImageConstraints:NO];
        }
    }
    else if (collection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
        // regular portrait phones
        self.coverImageView.hidden = NO;
        self.profilePictureLandscapeTopAnchorConstraint.active = NO;
        self.profilePicturePortraitTopAnchorConstraint.active = YES;
        
        [self activateiPhone6PlusLandscapeLayout:NO];
        [self activateCoverImageConstraints:YES];
    }
}


@end
