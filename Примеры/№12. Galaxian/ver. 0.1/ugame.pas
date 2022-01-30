unit ugame;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type
  TPlayer = record
    img : TBitmap;
    xPos, yPos : Integer;
    W, H : Integer;
  end;

type
  TBot = class
  public
    img : TBitmap;
    xPos, yPos : Integer;
    W, H : Integer;
    isVisable : Boolean;
    health : Integer;
    constructor Create(x, y : integer);
  end;

type
  TBullet = class
  public
    img : TBitmap;
    xPos, yPos : Integer;
    W, H : Integer;
    isVisable : Boolean;
    constructor Create(play: TPlayer);
  end;

type

  { TGame }

  TGame = class(TForm)
    Timer1: TTimer;
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure Load();
    procedure Frame();
    procedure UpdateGame();
  public

  end;

var
  Game: TGame;
  player : TPlayer;
  ListBot: TList;
  ListBullet: TList;
  isFinish : Boolean;


const StepPlayer = 3;

implementation

{$R *.lfm}
// -----------------------------------------------
// Конструктор TBot
constructor TBot.Create(x, y : integer);
begin
  img := TBitmap.Create;
  img.LoadFromFile('assets\bot.bmp');
  H := img.Height;
  W := img.Width;
  xPos := x;
  yPos := y;
  isVisable := true;
  health := 3;
end;


// -----------------------------------------------
// Конструктор TBullett
constructor TBullet.Create(play: TPlayer);
begin
  img := TBitmap.Create;
  img.LoadFromFile('assets\bullet.bmp');
  H := img.Height;
  W := img.Width;
  xPos := play.xPos + (play.W div 2);
  yPos := play.yPos;
  isVisable := true;
end;

// -----------------------------------------------
procedure TGame.Load();
begin
  isFinish := false;

  // Создание играка
  player.img := TBitmap.Create;
  player.img.LoadFromFile('assets\Player.bmp');
  player.H := player.img.Height;
  player.W := player.img.Width;
  player.xPos := (Game.Width div 2) - player.W div 2;
  player.yPos := Game.Height - player.H;

  // Создание пуль
  ListBullet := TList.Create;

  // Создание ботов
  ListBot := TList.Create;
  ListBot.Add(TBot.Create(  0, 10));
  ListBot.Add(TBot.Create( 70, 10));
  ListBot.Add(TBot.Create(140, 10));
  ListBot.Add(TBot.Create(210, 10));

end;

procedure TGame.Frame();
var
  i : integer;
begin
  // Игрок
  Canvas.Draw(player.xPos, player.yPos, player.img);

  // Боты
  for i := 0 to ListBot.Count-1 do
    if  (TBot(ListBot[i]).isVisable) then
      Canvas.Draw(TBot(ListBot[i]).xPos,
                  TBot(ListBot[i]).yPos,
                  TBot(ListBot[i]).img);

  // Пули
  for i := 0 to ListBullet.Count-1 do
    if  (TBullet(ListBullet[i]).isVisable) then
      Canvas.Draw(TBullet(ListBullet[i]).xPos,
                  TBullet(ListBullet[i]).yPos,
                  TBullet(ListBullet[i]).img);

end;

procedure TGame.UpdateGame();
var
  i, j : integer;
begin

  for i := 0 to ListBullet.Count-1 do begin
    // перемещение пули
    if  (TBullet(ListBullet[i]).isVisable) then
      TBullet(ListBullet[i]).yPos := TBullet(ListBullet[i]).yPos - StepPlayer;

    // проверка - выход за приделы окна
    if ( TBullet(ListBullet[i]).yPos < 0 ) then begin
      TBullet(ListBullet[i]).isVisable := false;
      ListBullet.Remove(TBullet(ListBullet[i]));
      Break;
    end;

    // проверка - столкновение с ботом
    for j := 0 to ListBot.Count-1 do
      if ((TBullet(ListBullet[i]).yPos) < (TBot(ListBot[j]).yPos+TBot(ListBot[j]).h)) and
         ((TBullet(ListBullet[i]).yPos) > (TBot(ListBot[j]).yPos)) and
         ((TBullet(ListBullet[i]).xPos) > (TBot(ListBot[j]).xPos)) and
         ((TBullet(ListBullet[i]).xPos) < (TBot(ListBot[j]).xPos+TBot(ListBot[j]).w)) and
         (TBullet(ListBullet[i]).isVisable) then
         begin
           TBot(ListBot[j]).health := TBot(ListBot[j]).health - 1;
           TBullet(ListBullet[i]).isVisable := false;

           if TBot(ListBot[j]).health <= 0 then
           begin
             ListBot.Remove(TBot(ListBot[j]));
             Break;
           end;
         end;


  end;

  if ListBot.Count = 0 then begin
    isFinish := true;
    ShowMessage('Победа !!!');
  end;

  /// Caption := ListBullet.Count.ToString;

end;

// ----------------------------------------------------

procedure TGame.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key in ['a'] then player.xPos := player.xPos - StepPlayer;
  if key in ['d'] then player.xPos := player.xPos + StepPlayer;
  if key in [' '] then ListBullet.Add(TBullet.Create(player));
end;

procedure TGame.FormPaint(Sender: TObject);
begin
  if not (isFinish) then begin
    Frame();
    UpdateGame();
  end;
end;

procedure TGame.FormShow(Sender: TObject);
begin
 Load();
end;

procedure TGame.Timer1Timer(Sender: TObject);
begin
  Repaint;
end;

end.

