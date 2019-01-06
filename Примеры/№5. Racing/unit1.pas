unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Panel1: TPanel;
    Timer1: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  isGame : Boolean;
  fin : Integer;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  isGame := true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  isGame := false;
  Randomize;
  fin :=  Image5.Left + Image5.Width;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if (isGame) then begin

    if (Image1.Left < fin)and(Image2.Left < fin)and
       (Image3.Left < fin)and(Image4.Left < fin)then begin
           Image1.Left:=Image1.Left+Random(5);
           Image2.Left:=Image2.Left+Random(5);
           Image3.Left:=Image3.Left+Random(5);
           Image4.Left:=Image4.Left+Random(5);
       end;
  end;

end;

end.

