#ifndef movement_h
#define movement_h

#define uint unsigned int

void setCoordinates();

void moveLeft();
void moveDown();
void moveRight();
void moveUp();

int isGrass();
int isMapChange();

void getMapChange();
void changeMap(unsigned short mapIndex);
void unsetRedraw();

void keyStroke(int keycode);

void setEncounter();
void finishEncounter();
int isEncounter();
void encounter();
void menuSelect(int key);
void attack(int moveID, int who);
void menuEnter();
void enemyTurn();

#endif
