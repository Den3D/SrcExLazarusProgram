unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Label1: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure ImgClick(Sender: TObject; i, j : Integer);
    procedure StartGame(Sender: TObject);
    procedure isFinish(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  player : integer;
  a : array[1..3,1..3] of Integer;
  isf : Boolean;
  CountClick : Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.StartGame(Sender: TObject);
var
  i, j : Integer;
begin
  player := 1;
  Label1.Caption:= inttostr(player);
  isf := false;
  CountClick :=0;

  for i := 1 to 9 do begin
    TImage( FindComponent('Image'+inttostr(i))).Picture.LoadFromFile('img\i.png');
    TImage( FindComponent('Image'+inttostr(i))).Enabled:= true;
  end;

  for i := 1 to 3 do
    for  j:= 1 to 3 do
      a[i,j] := 0;

end;


procedure TForm1.isFinish(Sender: TObject);
var
  i : Integer;
begin

  for i:=1 to 3 do
    if ((a[i,1]=a[i,2])and(a[i,2]=a[i,3])and(player=a[i,1])) then
       begin isf := true; end else
    if ((a[1,i]=a[2,i])and(a[2,i]=a[3,i])and(player=a[1,i])) then
       begin isf := true; end;

  if ((a[1,1]=a[2,2])and(a[2,2]=a[3,3])and(player=a[1,1])) then
   begin isf := true; end;

  if ((a[1,3]=a[2,2])and(a[2,2]=a[3,1])and(player=a[1,3])) then
   begin isf := true; end;


 if (isf) then begin
  for i:=1 to 9 do
    TImage( FindComponent('Image'+inttostr(i))).Enabled:= false;
  Label1.Caption:='Победил игрок:' + inttostr(player);
 end else
 Label1.Caption:='Ход игрока:' + inttostr(player);

 if ((CountClick =9) and not(isf)) then
  Label1.Caption:='Ничья';


end;

procedure TForm1.ImgClick(Sender: TObject; i, j : Integer);
begin

  if (player = 1) then begin
    (Sender as TImage).Picture.LoadFromFile('img\i_x.png');
    (Sender as TImage).Enabled:=false;
    a[i,j] := player;
    CountClick := CountClick +1;
    isFinish ( Sender );
    player:= 2;
  end else

  if (player = 2) then begin
    (Sender as TImage).Picture.LoadFromFile('img\i_o.png');
    (Sender as TImage).Enabled:=false;
    a[i,j] := player;
    CountClick := CountClick +1;
    isFinish ( Sender );
    player:= 1;
  end;


  Memo1.Clear;
  Memo1.Lines.Add(inttostr(a[1,1])+' '+inttostr(a[1,2])+' '+inttostr(a[1,3]));
  Memo1.Lines.Add(inttostr(a[2,1])+' '+inttostr(a[2,2])+' '+inttostr(a[2,3]));
  Memo1.Lines.Add(inttostr(a[3,1])+' '+inttostr(a[3,2])+' '+inttostr(a[3,3]));


end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  StartGame ( Sender );
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  StartGame (Sender);
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  ImgClick (Sender, 1, 1);
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  ImgClick (Sender, 1, 2);
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
  ImgClick (Sender, 1, 3);
end;

procedure TForm1.Image4Click(Sender: TObject);
begin
  ImgClick (Sender, 2, 1);
end;

procedure TForm1.Image5Click(Sender: TObject);
begin
  ImgClick (Sender, 2, 2);
end;

procedure TForm1.Image6Click(Sender: TObject);
begin
  ImgClick (Sender, 2, 3);
end;

procedure TForm1.Image7Click(Sender: TObject);
begin
  ImgClick (Sender, 3, 1);  ;
end;

procedure TForm1.Image8Click(Sender: TObject);
begin
  ImgClick (Sender, 3, 2);
end;

procedure TForm1.Image9Click(Sender: TObject);
begin
  ImgClick (Sender, 3, 3);
end;



end.

