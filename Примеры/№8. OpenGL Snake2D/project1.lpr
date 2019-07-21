program project1;


uses
  gl,
  glu,
  glut;

const
  AppWidth = 600;
  AppHeight = 600;
  step = 20;

const
  Key_W = 119;
  Key_S = 115;
  Key_A = 97;
  Key_D = 100;
  Key_ESC = 27;



type
  Naprav = (UP, DOWN, LEFT, RIHT);

type
  Snake = record
    PosX : Integer;
    PosY : Integer;
end;

type
  Apple = record
    PosX : Integer;
    PosY : Integer;
    Visible : Boolean;
end;


var
  ScreenWidth, ScreenHeidth: integer;
  countSnake : Integer;
  e1 : array[1..100] of Snake;
  app : Apple;
  vecSnake : Naprav;

procedure DrawQuad(mode : Integer);
begin
    glBegin(mode);
      glVertex2f(0.0, step);
      glVertex2f(0.0, 0.0);
      glVertex2f(step, 0.0);
      glVertex2f(step, step);
    glEnd;
end;

procedure CreateApple (value : Integer); cdecl;
var
  x, y : Integer;
begin
  Randomize;
  x := Random(ScreenWidth div step);
  y := Random(ScreenHeidth div step);
  app.PosX:= x * step;
  app.PosY:= y * step;
  app.Visible:= true;;

end;

procedure  StartGame;
begin
  countSnake:=3;
  vecSnake:= UP;

  e1[1].PosX:= 10 * step;
  e1[1].PosY:= 2 * step;

  e1[2].PosX:= 10 * step;
  e1[2].PosY:= 1 * step;

  e1[3].PosX:= 10 * step;
  e1[3].PosY:= 0 * step;
end;



procedure DrawGrid;
var
  i, j : Integer;
begin

glPushMatrix;
glColor3f(1.0,1.0,1.0);
glBegin(GL_LINES);

 for i := 0 to (ScreenWidth div step) do begin
   glVertex2f(0, i * step);
   glVertex2f(ScreenWidth, i * step);
 end;

 for j := 0 to (ScreenHeidth div step) do begin
   glVertex2f(j * step, 0);
   glVertex2f(j * step, ScreenHeidth);
 end;

 glEnd;
 glPopMatrix;

end;


procedure pressKey ( key : byte; x, y : Integer); cdecl;
begin
  case key of
    Key_W : vecSnake:= UP;
    Key_S : vecSnake:= DOWN;
    Key_A : vecSnake:= LEFT;
    Key_D : vecSnake:= RIHT;
    Key_ESC : halt;
  end;
end;

function isCollisionApple: Boolean;
begin
 if ((e1[1].PosX = app.PosX)and (e1[1].PosY = app.PosY)) then
 Result := true else Result:=false;
end;


procedure Update (value : Integer);  cdecl;
var
  i : Integer;
begin

 for i:= 2 to countSnake do
   if ((e1[1].PosX = e1[i].PosX)and(e1[1].PosY = e1[i].PosY)) then
   StartGame;

 if( isCollisionApple and app.Visible ) then
 begin
   app.Visible:= False;
   countSnake:= countSnake + 1;
   glutTimerFunc(6000, @CreateApple, 0);
 end;


 for i:= countSnake  downto 2 do
 begin
   e1[i].PosX:= e1[i-1].PosX;
   e1[i].PosY:= e1[i-1].PosY;
 end;

 case (vecSnake) of
   UP   : e1[1].PosY:= e1[1].PosY + step;
   DOWN : e1[1].PosY:= e1[1].PosY - step;
   RIHT : e1[1].PosX:= e1[1].PosX + step;
   LEFT : e1[1].PosX:= e1[1].PosX - step;
 end;

 if ( e1[1].PosX > ScreenWidth ) then e1[1].PosX := 0;
 if ( e1[1].PosX < 0 ) then e1[1].PosX := ScreenWidth;

 if ( e1[1].PosY > ScreenHeidth ) then e1[1].PosY := 0;
 if ( e1[1].PosY < 0 ) then e1[1].PosY := ScreenHeidth;


  glutTimerFunc(600, @Update, 0);
end;



procedure InitScene;
begin
  glClearColor(0.3, 0.7, 0.9, 1.0);
  glEnable( GL_DEPTH_TEST );

  StartGame;
end;

  procedure RenderScene;  cdecl;
  var
    i : Integer;
  begin
    glLoadIdentity;
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

    DrawGrid;

    if (app.Visible) then
    begin
      glPushMatrix;
        glColor3f(1.0,0.0,0.0);
        glTranslatef(app.PosX, app.PosY, 0.001);
        DrawQuad(GL_QUADS);
      glPopMatrix;
    end;



    for i:= 1 to countSnake do
    begin
      glPushMatrix;
        glColor3f(0.0,1.0,0.0);
        glTranslatef(e1[i].PosX, e1[i].PosY, 0.001);
        DrawQuad(GL_QUADS);
      glPopMatrix;

      glPushMatrix;
        glColor3f(0.0,0.0,0.0);
        glTranslatef(e1[i].PosX, e1[i].PosY, 0.002);
        DrawQuad(GL_LINE_LOOP);
      glPopMatrix;
    end;



    glutSwapBuffers;
    glutPostRedisplay;
  end;

  procedure Reshape(Width, Height: integer); cdecl;
  begin
    ScreenHeidth := Height;
    ScreenWidth  := Width;
    glViewport(0, 0, ScreenWidth, ScreenHeidth);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity;
    gluOrtho2D(0,ScreenWidth, 0, ScreenHeidth);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity;
  end;



begin
  glutInit(@argc, @argv);
  glutInitDisplayMode(GLUT_RGBA or GLUT_DOUBLE or GLUT_DEPTH);
  glutInitWindowSize(AppWidth, AppHeight);
  ScreenWidth := glutGet(GLUT_SCREEN_WIDTH);
  ScreenHeidth := glutGet(GLUT_SCREEN_HEIGHT);
  glutInitWindowPosition((ScreenWidth - AppWidth) div 2,
    (ScreenHeidth - AppHeight) div 2);
  glutCreateWindow('Game');


  InitScene;

  glutKeyboardFunc(@pressKey);
  glutDisplayFunc(@RenderScene);
  glutReshapeFunc(@Reshape);

  glutTimerFunc(600, @Update, 0);
  glutTimerFunc(600, @CreateApple, 0);

  glutMainLoop;

end.

