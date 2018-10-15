unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    procedure ButtonClick(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ButtonClick(Sender: TObject);
begin
    {
  if Sender = Button1 then Caption:= Button1.Caption;
   if Sender = Button2 then Caption:= Button2.Caption;
    if Sender = Button3 then Caption:= Button3.Caption;
    }

  if (Sender is TButton) then
  Caption:= (Sender as TButton).Caption;

end;




end.

