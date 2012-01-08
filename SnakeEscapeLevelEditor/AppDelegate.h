//
//  AppDelegate.h
//  SnakeEscapeLevelEditor
//
//  Created by Lennart Hansen on 28.12.11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "cocos2d.h"
#import "WorldScene.h"
@interface SnakeEscapeLevelEditorAppDelegate : NSObject <NSApplicationDelegate,WorldSceneDelegate>
{
    IBOutlet NSComboBox *levelPackDropDown;
    IBOutlet NSTextField *levelNameTextField;
    IBOutlet NSTextField *levelZeitTextField;
    IBOutlet NSTextField *nextLevelNameTextField;
    IBOutlet NSTextField *levelBreiteTextField;
    IBOutlet NSTextField *rotationTextfield;
    IBOutlet NSStepper *stepper;
    IBOutlet NSTextField *AstSchalterPositionX;
    IBOutlet NSTextField *AstSchalterPositionY;
    IBOutlet NSTextField *AstSchalterRotation;
    IBOutlet NSPopUpButton *AstSchalterTarget;
	NSWindow	*window_;
	MacGLView	*glView_;
    WorldScene* worldScene;
    NSButton *addAstSchalter;
}

@property (assign) IBOutlet NSWindow	*window;
@property (assign) IBOutlet MacGLView	*glView;

- (IBAction)RotationChange:(id)sender;
-(IBAction)addAstNormal:(id)sender;
-(IBAction)addVerkohlterAst:(id)sender;
-(IBAction)addStacheligerAst:(id)sender;
-(IBAction)addAstHindernis:(id)sender;
- (IBAction)addAstSchalter:(id)sender;
-(IBAction)toggleHilfsLinien:(id)sender;
- (IBAction)generieren:(id)sender;
- (IBAction)astLoeschen:(id)sender;
-(void)TextEdited;
@end
