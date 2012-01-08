//
//  HelloWorldLayer.h
//  SnakeEscapeLevelEditor
//
//  Created by Lennart Hansen on 28.12.11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//
#import "cocos2d.h"


@protocol WorldSceneDelegate <NSObject>

-(void)currentSpriteChanged;
@end
@interface WorldScene : CCLayer<CCMouseEventDelegate>
{
    NSMutableArray* AstSprites;
    NSArray* HilfslinienSprites;

    CCSprite* currentSprite;
    CCSprite* selectedRahmen;
    NSString *levelPack;
    NSString *levelName;
    NSString *levelZeit;
    NSString *nextLevelName;
    NSString *levelBreite;
    id<WorldSceneDelegate>delegate;
    NSMutableArray* astLabels;
    
    
}
-(void)addAstNormal;
-(void)addVerkohlterAst;
-(void)addStacheligerAst;
-(void)addPortalExit;
-(void)addPortalEntry;
-(void)addAstHindernis;
-(void)addAstSchalter;
-(void)toggleHilfslinien;
-(void)generieren;
-(void)AstLabelsgenerieren;
@property (assign)id <WorldSceneDelegate>delegate;
@property(assign)CCSprite* currentSprite;
@property(assign)NSMutableArray* AstSprites;
@property (assign)NSString* levelPack;
@property (assign)NSString* levelName;
@property (assign)NSString* levelZeit;
@property (assign)NSString* nextLevelName;
@property (assign)NSString* levelBreite;
@property (assign)CCSprite* selectedRahmen;
@end
