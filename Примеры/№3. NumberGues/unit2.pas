unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { TForm2 }

  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation
   uses unit1;
{$R *.lfm}

{ TForm2 }

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  //
  Form1.ins     := StrToInt( Edit1.Text );
  Form1.begN  := StrToInt( Edit2.Text );
  Form1.endN  := StrToInt( Edit3.Text );

  Form1.Label2.Caption:= 'Отгадай число от ' + IntToStr(Form1.begN)+' до '+ IntToStr(Form1.endN);
  Form1.NewGame;

  Close;
end;

end.

