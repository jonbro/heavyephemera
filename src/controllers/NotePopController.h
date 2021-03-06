#pragma once
#import "ofMain.h"
#import "Button.h"
#import "ofxMSAInteractiveObject.h"
#import "MSAShape3D.h"
#import "RootModel.h"
#import "glu.h"

class MainController;

class NotePopController : public ofxMSAInteractiveObject{
public:
	void setup();
	void draw();
	void update();
	
	void initDisplay();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	bool hitTest(ofTouchEventArgs &touch);
	
	void drawRect(int x, int y, int width, int height, int inputWidth, int inputHeight, int offset_x, int offset_y, int texture);
	void drawRect(int x, int y, int width, int height, int offset_x, int offset_y, int texture);
	
	Button leftPane, rightPane;
	bool fingerDown1, fingerDown2;
	int fingerNumber1, fingerNumber2;
	float fingerPos1, fingerPos2;
	
	float sliderOffset1, sliderOffset2;
	MainController *mainController;
	RootModel *rootModel;
	ofImage bg, fg, notes, octaves;
	MSA::Shape3D myShape;
	int showTime, noteNum, octaveNum, editTargetX, editTargetY;
};