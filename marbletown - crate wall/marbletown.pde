import megamu.shapetween.*;
import SimpleOpenNI.*;
float event = 1.0;
int whichHand = 0;
Tween picktween, yourtween, favoritetween;
PShape pick, your, favorite, thisinst, kinect, standon, hello, readytovote, cratewall, 
E11, E12, E13, E14, E15, E21, E22, E23, E24, E25, E31, E32, E33, E34, E35, E41, E42, E43, E44, E45;
Timer event1, offset, offset2, offset3;
SimpleOpenNI context;
Checkers Check;
PVector com = new PVector();                                   
PVector com2d = new PVector(); 
int playerID;

void setup() {
  size(1366, 768);
  smooth();
  strokeWeight(3);
  context = new SimpleOpenNI(this);
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }
  context.setMirror(true);
  pick = loadShape("EVENT1_pick.svg");
  your = loadShape("EVENT1_your.svg");
  favorite = loadShape("EVENT1_favorite.svg");
  thisinst = loadShape("EVENT2_thisinstallation.svg");
  kinect = loadShape("EVENT2_thekinect.svg");
  standon = loadShape("EVENT2_standon.svg");
  hello = loadShape("EVENT3_hello.svg");
  readytovote = loadShape("EVENT3_readytovote.svg");
  cratewall = loadShape("EVENT3_cratewall.svg");
  E11 = loadShape("E_1_1.svg");
  E12 = loadShape("E_1_2.svg");
  E13 = loadShape("E_1_3.svg");
  E14 = loadShape("E_1_4.svg");
  E15 = loadShape("E_1_5.svg");
  E21 = loadShape("E_2_1.svg");
  E22 = loadShape("E_2_2.svg");
  E23 = loadShape("E_2_3.svg");
  E24 = loadShape("E_2_4.svg");
  E25 = loadShape("E_2_5.svg");
  E31 = loadShape("E_3_1.svg");
  E32 = loadShape("E_3_2.svg");
  E33 = loadShape("E_3_3.svg");
  E34 = loadShape("E_3_4.svg");
  E35 = loadShape("E_3_5.svg");
  E41 = loadShape("E_4_1.svg");
  E42 = loadShape("E_4_2.svg");
  E43 = loadShape("E_4_3.svg");
  E44 = loadShape("E_4_4.svg");
  E45 = loadShape("E_4_5.svg");




  picktween = new Tween(this, 50, Tween.FRAMES, Tween.QUADRATIC);
  yourtween = new Tween(this, 50, Tween.FRAMES, Tween.QUADRATIC);
  favoritetween = new Tween(this, 50, Tween.FRAMES, Tween.QUADRATIC);
  picktween.setPlayMode(Tween.REPEAT);
  yourtween.setPlayMode(Tween.REPEAT);
  favoritetween.setPlayMode(Tween.REPEAT);
  event1 = new Timer(5000);
  event1.start();
  offset = new Timer(200);
  offset.start();
  offset2 = new Timer(400);
  offset2.start();
  offset3 = new Timer(200);
  offset3.start();

  context.enableDepth();
  context.enableUser();

  //context = new SimpleOpenNI(this);
  //if(context.isInit() == false)
  //{
  //println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
  //exit();
  //return;  
  // }
}


void draw() {
  background(255, 255, 0);
  Check = new Checkers();
  Check.checker();

  //openNI stuff

  context.update();
  //image(context.userImage(),0,0);
  int[] userList = context.getUsers();
  for (int i=0; i<userList.length; i++)
  {
    if (context.isTrackingSkeleton(userList[i]))
    {
      //  stroke(userClr[ (userList[i] - 1) % userClr.length ] );
      //    drawSkeleton(userList[i]);
    }
    if (context.getCoM(userList[i], com))
    {
      context.convertRealWorldToProjective(com, com2d);
      // println(com2d.x, com2d.y);
      text(Integer.toString(userList[i]), com2d.x, com2d.y);

      if (com2d.x > 200 && com2d.x < 400) {
        event = 2.0;
        if (event < 2.0) {
          offset3.start();
          picktween.resume();
          yourtween.resume();
        }
        playerID = userList[i];

        //  stroke(0);
        // strokeWeight(60);
        //       drawSkeleton(playerID);
        println("player is " + playerID + "or" + userList[i]);
      }
    }
  }








  //image(context.userImage(),0,0);
  //events 1.0 - 1.2 are the main menu, when nothing is detected.
  if (event == 1.0) {
    yourtween.pause();
    favoritetween.pause();

    shape(pick, width * (1-picktween.position()), 0);
    if (picktween.position() == 1) {
      picktween.pause();
    }


    if (offset.isFinished()) {
      //offset.pause();
      yourtween.resume();
      shape(your, width * (1-yourtween.position()), 0);
      if (yourtween.position() == 1) {
        yourtween.pause();
      }
    }

    if (offset2.isFinished()) {
      favoritetween.resume();
      shape(favorite, width * (1-favoritetween.position()), 0);
      if (favoritetween.position() == 1) {
        favoritetween.pause();
      }
    }
    if (event1.isFinished()) {
      event = 1.1;
      offset.start();
      offset2.start();
      event1.start();
      picktween.start();
      picktween.pause();
      yourtween.start();
      yourtween.pause();
      favoritetween.start();
      favoritetween.pause();
    }
  }


  if (event == 1.1) {    
    picktween.resume();

    shape(pick, width * ((picktween.position())*(-1)), 0);
    shape(your, width * (yourtween.position()*(-1)), 0);
    shape(favorite, width * ((favoritetween.position())*(-1)), 0);
    shape(thisinst, width - (width*((picktween.position()))), 0);
    shape(kinect, width - (width*(yourtween.position())), 0);
    shape(standon, width - (width*((favoritetween.position()))), 0);

    if (picktween.position() == 1) {
      picktween.pause();
    }

    if (offset.isFinished()) {
      yourtween.resume();     
      if (yourtween.position() == 1) {
        yourtween.pause();
      }
    }

    if (offset2.isFinished()) {
      favoritetween.resume();

      if (favoritetween.position() == 1) {
        favoritetween.pause();
      }
    }
    if (event1.isFinished()) {
      event = 1.2;
      offset.start();
      offset2.start();
      event1.start();
      picktween.start();
      picktween.pause();
      yourtween.start();
      yourtween.pause();
      favoritetween.start();
      favoritetween.pause();
    }
  }
  if (event == 1.2) {
    picktween.resume();

    shape(pick, width * (1-(picktween.position())), 0);
    shape(your, width * (1-yourtween.position()), 0);
    shape(favorite, width * (1-(favoritetween.position())), 0);
    shape(thisinst, 0 - (width*((picktween.position()))), 0);
    shape(kinect, 0 - (width*(yourtween.position())), 0);
    shape(standon, 0 - (width*((favoritetween.position()))), 0);

    if (picktween.position() == 1) {
      picktween.pause();
    }

    if (offset.isFinished()) {
      yourtween.resume();     
      if (yourtween.position() == 1) {
        yourtween.pause();
      }
    }

    if (offset2.isFinished()) {
      favoritetween.resume();

      if (favoritetween.position() == 1) {
        favoritetween.pause();
      }
    }
    if (event1.isFinished()) {
      event = 1.1;
      offset.start();
      offset2.start();
      event1.start();
      picktween.start();
      picktween.pause();
      yourtween.start();
      yourtween.pause();
      favoritetween.start();
      favoritetween.pause();
    }
  }

  //once user skeleton detected
  if (event == 2.0) {
    // pushMatrix();
    shape(cratewall, 0, 0);


    //   popMatrix();
    noStroke();

    //    picktween.resume();
    //  yourtween.resume();
  //  shape(hello, 0, height*(abs(picktween.position()-1)));

    if (picktween.position() == 1) {
      picktween.pause();
    }

    if (offset3.isFinished() ) {
      yourtween.resume();
    //  shape(readytovote, 0, height*(abs(yourtween.position()-1)));
      if (yourtween.position() == 1) {
        yourtween.pause();
      }
    }  





    //selection stuff goes here
    PVector rightHand = new PVector();
    context.getJointPositionSkeleton(playerID, SimpleOpenNI.SKEL_RIGHT_HAND, rightHand);
    PVector leftHand = new PVector();
    context.getJointPositionSkeleton(playerID, SimpleOpenNI.SKEL_LEFT_HAND, leftHand);
    PVector leftShoulder = new PVector();
    context.getJointPositionSkeleton(playerID, SimpleOpenNI.SKEL_LEFT_SHOULDER, leftShoulder);
    PVector rightShoulder = new PVector();
    context.getJointPositionSkeleton(playerID, SimpleOpenNI.SKEL_RIGHT_SHOULDER, rightShoulder);

    if (leftHand.z > rightHand.z) {
      whichHand = 1;
      println("left");
    } else {
      whichHand = 2;
      println("right");
    }
    PVector pointTo = new PVector();
    if (whichHand == 1) {
      pointTo.y = (((rightHand.y-rightShoulder.y)*rightShoulder.z)/(rightShoulder.z-rightHand.z))+rightShoulder.y;
      pointTo.x = (((rightHand.x-rightShoulder.x)*rightShoulder.z)/(rightShoulder.z-rightHand.z))+rightShoulder.x;
    } else if (whichHand == 2) {
      pointTo.y = (((leftHand.y-leftShoulder.y)*leftShoulder.z)/(leftShoulder.z-leftHand.z))+leftShoulder.y;
      pointTo.x = (((leftHand.x-leftShoulder.x)*leftShoulder.z)/(leftShoulder.z-leftHand.z))+leftShoulder.x;
    }

    if (pointTo.y >= 800 && pointTo.y < 3000) {
     // println("top");
      if (pointTo.x > -200 && pointTo.x < 200) {   
        shape(E13, 0, 0);
      }
      if (pointTo.x > 200 && pointTo.x < 900) {   
        shape(E14, 0, 0);
      }
      if (pointTo.x > 900 && pointTo.x < 3000) {   
        shape(E15, 0, 0);
      }
      if (pointTo.x > -900 && pointTo.x < -200) {   
        shape(E12, 0, 0);
      }
      if (pointTo.x > -3000 && pointTo.x < -900) {   
        shape(E11, 0, 0);
      }
    } else if (pointTo.y < 750 && pointTo.y >= 200) {
     // println("second from top");
      if (pointTo.x > -200 && pointTo.x < 200) {   
        shape(E23, 0, 0);
      }
      if (pointTo.x > 200 && pointTo.x < 900) {   
        shape(E24, 0, 0);
      }
      if (pointTo.x > 900 && pointTo.x < 3000) {   
        shape(E25, 0, 0);
      }
      if (pointTo.x > -900 && pointTo.x < -200) {   
        shape(E22, 0, 0);
      }
      if (pointTo.x > -3000 && pointTo.x < -900) {   
        shape(E21, 0, 0);
      }
    } else if (pointTo.y < 150 && pointTo.y >= -500) {
     // println("second from bottom");
      if (pointTo.x > -200 && pointTo.x < 200) {   
        shape(E33, 0, 0);
      }
      if (pointTo.x > 200 && pointTo.x < 900) {   
        shape(E34, 0, 0);
      }
      if (pointTo.x > 900 && pointTo.x < 3000) {   
        shape(E35, 0, 0);
      }
      if (pointTo.x > -900 && pointTo.x < -200) {   
        shape(E32, 0, 0);
      }
      if (pointTo.x > -3000 && pointTo.x < -900) {   
        shape(E31, 0, 0);
      }
    } else if (pointTo.y < -500 && pointTo.y > -3000) {
   //   println("bottom");
      if (pointTo.x > -200 && pointTo.x < 200) {   
        shape(E43, 0, 0);
      }
      if (pointTo.x > 200 && pointTo.x < 900) {   
        shape(E44, 0, 0);
      }
      if (pointTo.x > 900 && pointTo.x < 3000) {   
        shape(E45, 0, 0);
      }
      if (pointTo.x > -900 && pointTo.x < -200) {   
        shape(E42, 0, 0);
      }
      if (pointTo.x > -3000 && pointTo.x < -900) {   
        shape(E41, 0, 0);
      }
    }


    drawSkeleton(playerID);
      println(pointTo);
  }

}


















void drawSkeleton(int userId)
{
  // to get the 3d joint data
  /*
  PVector jointPos = new PVector();
   context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
   println(jointPos);
   */
  pushMatrix();
  translate(363, 400);
  strokeWeight(50);
  stroke(255, 60, 60);
  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);


  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  
  popMatrix();
}

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");

  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}

