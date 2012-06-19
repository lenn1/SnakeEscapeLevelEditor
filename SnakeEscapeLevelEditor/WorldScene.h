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
    CCSprite* bg;
    NSString* backgroundImageName;
    CCLayer* background;
}
-(void)addAstNormal;
-(void)addVerkohlterAst;
-(void)addStacheligerAst;
-(void)addPortalExit;
-(void)addPortalEntry;
-(void)addBaumkrone;
-(void)addAstHindernis;
-(void)addAstSchalter;
-(void)addRutschigerAst;
-(void)addBaumharz;
-(void)addWasserfall;
-(void)addStein;
-(void)addVogel;
-(void)addFeuer;
-(void)addSpinne;
-(void)addBaum;
-(void)addAffe;
-(void)addAstKatapult;
-(void)toggleHilfslinien;
-(void)generieren;
-(void)AstLabelsgenerieren;
-(void)changeBackGroundTo:(int)buschNummer;
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
