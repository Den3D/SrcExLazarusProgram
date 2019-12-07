unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
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

  Money : Integer;
  CarID : Integer;
  Stavka : Integer;

  f1, f2, f3, f4 : Boolean;

  CarF : array[1..4] of integer;
  i : integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  isGame := true;
  Stavka:= StrToInt(Edit1.Text);
  if  (Stavka >  Money) then  begin
     Stavka :=  Money;
     Edit1.Text:= IntToStr(Money);
  end;


  Money:= Money - Stavka;
  Label1.Caption:= IntToStr(Money);
  CarID := ComboBox1.ItemIndex + 1;

  BitBtn1.Enabled:= false;
  f1 := false;
  f2 := false;
  f3 := false;
  f4 := false;

  Image1.Left:= 24;
  Image2.Left:= 24;
  Image3.Left:= 24;
  Image4.Left:= 24;

  i := 1;
  Memo1.Clear;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  isGame := false;
  Randomize;
  fin :=  Image5.Left + Image5.Width;
  Money := 1000;
  Label1.Caption:= IntToStr(Money);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if (isGame) then begin

  //-----------------------------------------
    if (not f1) then
      if (Image1.Left < fin) then
           Image1.Left:=Image1.Left+Random(5)
      else begin
           Memo1.Lines.Add('Машина № 1');
           f1 := true;
           CarF[i] := 1;
           inc(i);
      end;

   //-----------------------------------------
   if (not f2) then
      if (Image2.Left < fin) then
           Image2.Left:=Image2.Left+Random(5)
      else begin
           Memo1.Lines.Add('Машина № 2');
           f2 := true;
           CarF[i] := 2;
           inc(i);
      end;

    //-----------------------------------------
    if (not f3) then
      if (Image3.Left < fin) then
           Image3.Left:=Image3.Left+Random(5)
      else begin
           Memo1.Lines.Add('Машина № 3');
           f3 := true;
           CarF[i] := 3;
           inc(i);
      end;

    //-----------------------------------------
    if (not f4) then
      if (Image4.Left < fin) then
           Image4.Left:=Image4.Left+Random(5)
      else begin
           Memo1.Lines.Add('Машина № 4');
           f4 := true;
           CarF[i] := 4;
           inc(i);
      end;

       //-----------------------------------------

     if ( f1 and f2 and f3 and f4) then
       begin
          if CarID = CarF[1] then Money:= Money + (Stavka*2);
           Label1.Caption:= IntToStr(Money);
           BitBtn1.Enabled:= true;
           isGame := false;

           if (Money <= 0) then begin
             Label2.Visible:=true;
              BitBtn1.Enabled:= false;
           end;
       end;


  end;  //  if (isGame)

end;

end.

