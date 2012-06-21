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
    IBOutlet NSTextField *scaleTextfield;
    IBOutlet NSStepper *stepper;
    IBOutlet NSTextField *AstSchalterPositionX;
    IBOutlet NSTextField *AstSchalterPositionY;
    IBOutlet NSTextField *AstSchalterRotation;
    IBOutlet NSPopUpButton *AstSchalterTarget;
    IBOutlet NSComboBox *buschbox;
    IBOutlet NSComboBox *baumkronenBox;
    IBOutlet NSComboBox *baumBox;
    IBOutlet NSStepper *scaleStepper;
	NSWindow	*window_;
	MacGLView	*glView_;
    WorldScene* worldScene;
    NSButton *addAstSchalter;
    NSButton *addWasserfall;
    NSButton *addStein;
}

@property (assign) IBOutlet NSWindow	*window;
@property (assign) IBOutlet MacGLView	*glView;

- (IBAction)BaumSpriteChanged:(id)sender;
- (IBAction)BaumKronenSpriteChanged:(id)sender;

- (IBAction)addBaum:(id)sender;
- (IBAction)RotationChange:(id)sender;
- (IBAction)ScaleChange:(id)sender;
- (IBAction)addRutschigerAst:(id)sender;
- (IBAction)addBaumharz:(id)sender;
- (IBAction)addStein:(id)sender;
- (IBAction)addWasserfall:(id)sender;
- (IBAction)addBaumkrone:(id)sender;
- (IBAction)addVogel:(id)sender;
- (IBAction)addFeuer:(id)sender;
- (IBAction)addSpinne:(id)sender;
- (IBAction)addAffe:(id)sender;
- (IBAction)addAstKatapult:(id)sender;
-(IBAction)addAstNormal:(id)sender;
-(IBAction)addVerkohlterAst:(id)sender;
-(IBAction)addStacheligerAst:(id)sender;
-(IBAction)addAstHindernis:(id)sender;
- (IBAction)addAstSchalter:(id)sender;
-(IBAction)toggleHilfsLinien:(id)sender;
- (IBAction)generieren:(id)sender;
- (IBAction)astLoeschen:(id)sender;
- (IBAction)hintergrundwechseln:(id)sender;
-(void)TextEdited;
@end
