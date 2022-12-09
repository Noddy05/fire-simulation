
float[][] pixelValues;

//Cooling map parameters:
int coolingSpots = 15;
int smoothSteps = 20;

//Fire spread parameters:
int sparksPerFrame = 5;

void setup(){
  size(400, 400);
  pixelValues = new float[width][height];
  for(int y = 0; y < height; y++){
    for(int x = 0; x < width; x++){
      pixelValues[x][y] = 0;
    }
  }
}

void drawMap(float[][] map){
  for(int y = 0; y < height; y++){
    for(int x = 0; x < width; x++){
      set(x, y, color(map[x][y] * 255));
    }
  }
}

float offset = 0;
float cooling = 0.0001;
void draw(){
  float[][] currentPixelValues = new float[width][height];
  arrayCopy(pixelValues, currentPixelValues);
  
  offset += 0.88;
  background(30);
  for(int i = 0; i < sparksPerFrame; i++){
    pixelValues[int(random(width))][(height - int(random(5)) - 1 + int(offset)) % height] = 1;
  }
  for(int y = 0; y < height; y++){
    for(int x = 0; x < width; x++){
      pixelValues[x][y] = (currentPixelValues[int(mod(x - 1, width))][y] 
        + currentPixelValues[int(mod(x + 1, width))][y]
        + currentPixelValues[x][int(mod(y - 1, height))]
        + currentPixelValues[x][int(mod(y + 1, height))]) / 4;
      pixelValues[x][y] -= cooling * noise(x, y);
      pixelValues[x][y] = max(pixelValues[x][y], 0);
      set(x, y, color(pixelValues[x][int((y + offset) % height)] * 5550, pixelValues[x][int((y + offset) % height)] * 1555, 0));
    }
  }
}

float mod(float a, float c){
  return (a + c) % c;
}
