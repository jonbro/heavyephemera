/*
 *  scrollView.cpp
 *  ww
 *
 *  Created by jonbroFERrealz on 9/24/10.
 *  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "scrollView.h"

ScrollView::ScrollView(){
	numFingers = 0;
	offset.set(0, 0, 1.0);
}

void ScrollView::draw(){
	// standard size is 40 40
	ofPushMatrix();
	float cellSize = 40.0*offset.z;
	//printf("offsetx: %f", offset.x);
	int xOffset = -offset.x/cellSize;
	int yOffset = -offset.y/cellSize;
	ofTranslate(fmod(offset.x, cellSize), fmod(offset.y, cellSize), 0);
	float top = y;
	for (int x=0; x<width/cellSize+1; x++) {
		for (int y=0; y<height/cellSize+1; y++) {
			if ( // make sure we are not drawing outside of the array
				x+xOffset>=0&&
				y+yOffset>=0&&
				x+xOffset<NUMCELLSX&&
				y+yOffset<NUMCELLSY
			) {
				switch (rootModel->world[x+xOffset][y+yOffset][0]) {
					case 1:
						ofSetColor(255, 215, 0);
						break;
					case 2:
						ofSetColor(255, 64, 0);
						break;
					case 3:
						ofSetColor(0, 128, 255);
						break;
					default:
						ofSetColor(0, 0, 0);
						break;
				}
				if (cellSize>10) {
					ofRect(x*cellSize, y*cellSize+top, cellSize-1, cellSize-1);				
				}else{
					ofRect(x*cellSize, y*cellSize+top, cellSize, cellSize);				
				}
			}
		}		
	}
	ofPopMatrix();
	
	// draw the synth links...
	ofPushMatrix();
	ofTranslate(offset.x, offset.y+y, 0);

	for (int i=0; i<8; i++) {
		ofSetColor(0xFFFFFF);
		ofRect(rootModel->synthLinks[i].x*cellSize+2, rootModel->synthLinks[i].y*cellSize+2, cellSize/8.0, cellSize/8.0);
	}
	ofPopMatrix();
}
void ScrollView::update(){
	float cellSize = 40.0*offset.z;

	if (numFingers ==0) {
		if (offset.x>0) {
			offset.x = ofLerp(offset.x, 0.0, 0.3);
		}else if (offset.x<-NUMCELLSX*cellSize+width) {
			printf("bouncing back");
			offset.x = ofLerp(offset.x, -NUMCELLSX*cellSize+width, 0.3);
		}
		if (offset.y>0) {
			offset.y = ofLerp(offset.y, 0, 0.3);
		}else if (offset.y<-NUMCELLSY*cellSize+height) {
			offset.y = ofLerp(offset.y, -NUMCELLSY*cellSize+height, 0.3);
		}
		if (offset.z<0.2) {
			offset.z = ofLerp(offset.z, 0.2, 0.3);
		}
		if (offset.z>1.8) {
			offset.z = ofLerp(offset.z, 1.8, 0.3);
		}		
	}
}
void ScrollView::touchDown(ofTouchEventArgs &touch)
{
	fingerStartedInView[touch.id] = true;
	numFingers++;
	fingerStart[touch.id].set(touch.x, touch.y, 0);
	if (numFingers >=2) {
		fingerCenterStart = fingerStart[0]+(fingerStart[1]-fingerStart[0])*0.5;
		fingerDistStart = ofpLength(fingerStart[0]-fingerStart[1]);
	}
	printf("ScrollView touchDown, numfingers:%i hittest: %s\n", numFingers, hitTest(touch)?"true":"false");
	if (numFingers == 1 && hitTest(touch)) {
		setCell(touch);
	}
}
bool ScrollView::hitTest(ofTouchEventArgs &touch)
{
	if (touch.x > x && touch.x < width+x
		&& touch.y > y && touch.y < height+y) {
		return true;
	}
	return false;
}
void ScrollView::setCell(ofTouchEventArgs &touch)
{
	printf("ScrollView linking synths: %s\n", rootModel->linkingSynths?"true":"false");
	float cellSize = offset.z*40.0;
	int xOffset = (touch.x-offset.x)/cellSize;
	int yOffset = (touch.y-y-offset.y)/cellSize;
	if (rootModel->linkingSynths) {
		rootModel->synthLinks[rootModel->currentSynth].set(xOffset, yOffset, 0);
	}else {
		rootModel->world[xOffset][yOffset][0] = rootModel->currentState;
		rootModel->world[xOffset][yOffset][1] = rootModel->currentState;
	}
}
void ScrollView::touchMoved(ofTouchEventArgs &touch)
{
	fingerCurrent[touch.id].set(touch.x, touch.y, 0);
	if (numFingers==1 && hitTest(touch)) {
		setCell(touch);
		fingerStart[touch.id].set(touch.x, touch.y, 0);
	}else if (numFingers >=2) {
		fingerCenterCurrent = fingerCurrent[0]+(fingerCurrent[1]-fingerCurrent[0])*0.5;
		offset += fingerCenterCurrent - fingerCenterStart;
		fingerDistCurrent = ofpLength(fingerCurrent[0]-fingerCurrent[1]);
		/*printf("fingerDistCurrent: %f\n", fingerDistCurrent);
		printf("fingerDistDiff: %f\n", fingerDistCurrent-fingerDistStart);
		
		float cellSize = offset.z;
		 
		offset.z += (fingerDistCurrent-fingerDistStart)*0.007*offset.z; // that last thing should be a function of the current scale
		offset.z = ofClamp(offset.z, 0.2, 1.8);
		 
		offset.y *= offset.z;
		offset.x *= offset.z;
		*/
		fingerDistStart = fingerDistCurrent;
		fingerCenterStart = fingerCenterCurrent;
	}
	
}
void ScrollView::touchUp(ofTouchEventArgs &touch)
{
	if (fingerStartedInView[touch.id]) {
		numFingers--;
	}
	fingerStartedInView[touch.id] = false;
}


