//
//  AppDelegate.m
//  SnakeEscapeLevelEditor
//
//  Created by Lennart Hansen on 28.12.11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "AppDelegate.h"

@implementation SnakeEscapeLevelEditorAppDelegate
@synthesize window=window_, glView=glView_;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
	
	[director setDisplayFPS:NO];
	
	[director setOpenGLView:glView_];
	// EXPERIMENTAL stuff.
	// 'Effects' don't work correctly when autoscale is turned on.
	// Use kCCDirectorResize_NoScale if you don't want auto-scaling.
	[director setResizeMode:kCCDirectorResize_AutoScale];
	
	// Enable "moving" mouse event. Default no.
	[window_ setAcceptsMouseMovedEvents:NO];
	
	CCScene *scene = [CCScene node];
	worldScene = [WorldScene node];
    worldScene.delegate =self;
    [scene addChild: worldScene];
	
    [director runWithScene:scene];
    
    [levelPackDropDown selectItemAtIndex:0];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TextEdited) name:NSTextDidEndEditingNotification object:nil];
    [AstSchalterTarget removeAllItems];
    [AstSchalterTarget setAction:@selector(TextEdited)];
}

-(IBAction)addAstNormal:(id)sender
{
    [worldScene addAstNormal];
}
-(void)addVerkohlterAst:(id)sender
{
    [worldScene addVerkohlterAst];
}
-(void)addStacheligerAst:(id)sender
{
    [worldScene addStacheligerAst];
}
-(void)addAstHindernis:(id)sender
{
    [worldScene addAstHindernis];
}

- (IBAction)addAstSchalter:(id)sender 
{   
    [worldScene addAstSchalter];
}
- (IBAction)addRutschigerAst:(id)sender 
{
    [worldScene addRutschigerAst];
}

- (IBAction)addBaumharz:(id)sender 
{
    [worldScene addBaumharz];
}

- (IBAction)addStein:(id)sender 
{
    [worldScene addStein];

}
- (IBAction)addWasserfall:(id)sender 
{
    [worldScene addWasserfall];
}

- (IBAction)addBaumkrone:(id)sender 
{
    [worldScene addBaumkrone];
}

- (IBAction)addVogel:(id)sender 
{
    [worldScene addVogel];
}

- (IBAction)addFeuer:(id)sender 
{
    [worldScene addFeuer];
}

- (IBAction)addSpinne:(id)sender 
{
    [worldScene addSpinne];
}

- (IBAction)addAffe:(id)sender 
{
    [worldScene addAffe];
}

- (IBAction)addAstKatapult:(id)sender 
{
    [worldScene addAstKatapult];
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication
{
	return YES;
}
-(IBAction)toggleHilfsLinien:(id)sender
{
        [worldScene toggleHilfslinien];
}

- (IBAction)generieren:(id)sender 
{
    worldScene.levelPack = @"1";
    worldScene.levelName = [levelNameTextField stringValue];
    worldScene.nextLevelName = [nextLevelNameTextField stringValue];
    worldScene.levelZeit = [levelZeitTextField stringValue];
    worldScene.levelBreite = [levelBreiteTextField stringValue];
    [worldScene generieren];
}

- (IBAction)astLoeschen:(id)sender 
{
    if(worldScene.currentSprite.tag > 1)
    {
        [worldScene.currentSprite.parent removeChild:worldScene.currentSprite cleanup:YES];
        [[worldScene AstSprites]removeObject:worldScene.currentSprite];
        [worldScene AstLabelsgenerieren];
        [[worldScene selectedRahmen]setPosition:ccp(-1000,-2000)];
        worldScene.currentSprite = nil;
        [self currentSpriteChanged];
    }
}

- (IBAction)hintergrundwechseln:(id)sender 
{
    [worldScene changeBackGroundTo:[buschbox indexOfSelectedItem]+1];
}
- (void)dealloc
{
	[[CCDirector sharedDirector] end];
	[window_ release];
	[super dealloc];
}

#pragma mark AppDelegate - IBActions
-(void)TextEdited
{
    if(worldScene.currentSprite)
    {
        worldScene.currentSprite.rotation = [rotationTextfield floatValue];
        if(worldScene.currentSprite.tag == 6)
        {
            NSValue* positionOffset = [NSValue valueWithPoint:NSMakePoint(AstSchalterPositionX.floatValue, AstSchalterPositionY.floatValue)];
            [(NSMutableArray*)worldScene.currentSprite.userData replaceObjectAtIndex:0 withObject:positionOffset];
            NSNumber* rotationOffset = [NSNumber numberWithFloat:AstSchalterRotation.floatValue];
            [(NSMutableArray*)worldScene.currentSprite.userData replaceObjectAtIndex:1 withObject:rotationOffset];
            NSString* target = [[AstSchalterTarget selectedItem] title];
            [(NSMutableArray*)worldScene.currentSprite.userData replaceObjectAtIndex:2 withObject:target];
        }
 
    }
}
-(void)currentSpriteChanged
{
    [stepper setFloatValue:worldScene.currentSprite.rotation];
    [rotationTextfield setFloatValue:worldScene.currentSprite.rotation];
    
    if(worldScene.currentSprite.tag == 6) // ASTSCHALTER
    {
        [AstSchalterPositionX setEnabled:YES];
        [AstSchalterPositionY setEnabled:YES];
        [AstSchalterRotation setEnabled:YES];
        [AstSchalterTarget setEnabled:YES];
        
        NSValue* positionOffset = [(NSArray*)worldScene.currentSprite.userData objectAtIndex:0];
        AstSchalterPositionX.floatValue = positionOffset.pointValue.x;
        AstSchalterPositionY.floatValue = positionOffset.pointValue.y;
        
        NSNumber* rotationOffset = [(NSArray*)worldScene.currentSprite.userData objectAtIndex:1];
        AstSchalterRotation.floatValue = [rotationOffset floatValue];
        
        [AstSchalterTarget removeAllItems];
        int AstCounter = 1;
        for(CCSprite* ast in worldScene.AstSprites)
        {
            if(ast.tag !=0) // PORTALEXIT ausschliessen
            {
                [AstSchalterTarget addItemWithTitle:[NSString stringWithFormat:@"ast%d",AstCounter]];
                AstCounter++;
            }
        }
        NSString* target = [(NSArray*)worldScene.currentSprite.userData objectAtIndex:2];
        [AstSchalterTarget selectItemWithTitle:target];
    }
    else
    {
        [AstSchalterPositionX setEnabled:NO];
        [AstSchalterPositionY setEnabled:NO];
        [AstSchalterRotation setEnabled:NO];
        [AstSchalterTarget setEnabled:NO];
        AstSchalterPositionX.floatValue = 0;
        AstSchalterTarget.stringValue = @"";
        AstSchalterPositionY.floatValue = 0;
        AstSchalterRotation.floatValue = 0;
        
        [baumBox setEnabled:NO];
        [baumkronenBox setEnabled:NO];
        [scaleStepper setEnabled:NO];
        scaleTextfield.stringValue = @"";
    }
    
    
    if(worldScene.currentSprite.tag == 15)  // BAUM 
    {
        [baumBox setEnabled:YES];
        [scaleStepper setEnabled:YES];
        
        [scaleTextfield setFloatValue:worldScene.currentSprite.scale];

    }
    if(worldScene.currentSprite.tag == 16)  // BAUMKRONE
    {
        [baumkronenBox setEnabled:YES];
        [scaleStepper setEnabled:YES];
        [scaleTextfield setFloatValue:worldScene.currentSprite.scale];

        
    }
    
}
- (IBAction)BaumSpriteChanged:(id)sender 
{
    NSString* baumImageName = [NSString stringWithFormat:@"baum%d",[baumBox indexOfSelectedItem]+1];
    CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"%@.png",baumImageName]];
    [worldScene.currentSprite setTexture:tex];
    worldScene.currentSprite.userData = baumImageName;
    baumBox.stringValue = baumImageName;
}

- (IBAction)BaumKronenSpriteChanged:(id)sender 
{
    NSString* baumKronenImageName = [NSString stringWithFormat:@"baumkrone_%d",[baumkronenBox indexOfSelectedItem]+1];
    CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"%@.png",baumKronenImageName]];
    [worldScene.currentSprite setTexture:tex];
    
    worldScene.currentSprite.userData = baumKronenImageName;
    baumkronenBox.stringValue = baumKronenImageName;

}

- (IBAction)addBaum:(id)sender 
{
    [worldScene addBaum];
}

- (IBAction)RotationChange:(id)sender 
{
    worldScene.currentSprite.rotation = [sender floatValue];
    [rotationTextfield setFloatValue:worldScene.currentSprite.rotation];
}

- (IBAction)ScaleChange:(id)sender 
{
    worldScene.currentSprite.scale = [sender floatValue]/100;
    [scaleTextfield setFloatValue:worldScene.currentSprite.scale];

}





@end
