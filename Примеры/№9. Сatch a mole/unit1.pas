unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  JwaWindows;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Image1: TImage;
    ImgKrot1: TImage;
    ImgKrot10: TImage;
    ImgKrot11: TImage;
    ImgKrot12: TImage;
    ImgKrot13: TImage;
    ImgKrot2: TImage;
    ImgKrot3: TImage;
    ImgKrot4: TImage;
    ImgKrot5: TImage;
    ImgKrot6: TImage;
    ImgKrot7: TImage;
    ImgKrot8: TImage;
    ImgKrot9: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure ImgKrotClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  oldN, newN : integer;
  score : Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure MyCursor;
var
  cur  : Graphics.TBitmap;
  mask  : Graphics.TBitmap;
  IconInfo : TIconInfo;
begin
  cur :=  Graphics.TBitmap.Create;
  cur.LoadFromFile('img\molot.bmp');

  mask :=  Graphics.TBitmap.Create;
  mask.LoadFromFile('img\molotMask.bmp');

  IconInfo.fIcon := true;
  IconInfo.xHotspot:= cur.Width div 2;
  IconInfo.yHotspot:= cur.Height div 2;
  IconInfo.hbmColor:= cur.Handle;
  IconInfo.hbmMask:= mask.Handle;


  Screen.Cursors[1]:=CreateIconIndirect(IconInfo);
  Screen.Cursor:= 1 ;

  cur.Destroy;

end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 // Image2.Left:= x ;
 // Image2.Top:= y ;
end;

procedure TForm1.ImgKrotClick(Sender: TObject);
begin
  score := score + 1;
  edit1.Text := inttostr( score );

  (Sender as TImage).Visible := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  oldN := 1;
  newN := 1;
  score := 0;
  edit1.Text := inttostr( score );
  MyCursor;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Randomize;
  oldN := newN ;
  newN := Random(12) + 1;

  TImage(FindComponent('ImgKrot' + IntToStr(oldN))).Visible:=False;
  TImage(FindComponent('ImgKrot' + IntToStr(newN))).Visible:=true;


end;

end.

