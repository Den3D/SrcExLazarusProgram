unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButOK: TButton;
    EditNumber: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    MenuNewGame: TMenuItem;
    MenuOptions: TMenuItem;
    MenuExit: TMenuItem;
    procedure ButOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuNewGameClick(Sender: TObject);
    procedure MenuOptionsClick(Sender: TObject);
    procedure NewGame;
  private

  public
    begN, endN: integer; // интервал чисел
    ins  : Integer;      // число попыток

  end;

var
  Form1: TForm1;
  n  : Integer;   // вводимое число
  rn : Integer;   // загаданное число
  i  : Integer;

implementation
  uses unit2;
{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuNewGameClick(Sender: TObject);
begin
  //
  NewGame;
end;

procedure TForm1.MenuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //
  ins  := 5;
  begN := 1;
  endN := 10;
  Label2.Caption:= 'Отгадай число от ' + IntToStr(begN)+' до '+ IntToStr(endN);
  NewGame;
end;

procedure TForm1.ButOKClick(Sender: TObject);
begin
  n := StrToInt( EditNumber.Text );

  if ( rn = n) then begin
    Label4.Caption := 'Вы угадали число!!!';
    EditNumber.Enabled := False;
    ButOK.Enabled := False;
  end;

  if not(rn = n) then begin
    if ( rn > n) then Label4.Caption:= 'Введеное число меньше загаданного.';
    if ( rn < n) then Label4.Caption:= 'Введеное число больше загаданного.';
    i := i - 1;
    EditNumber.Clear;
  end;

  Label1.Caption := 'Количество попыток :' + IntToStr( i );

end;

procedure TForm1.MenuOptionsClick(Sender: TObject);
begin
  //
  Form2.ShowModal;
end;

procedure TForm1.NewGame;
begin
  //
  Randomize;
  rn := Random(endN) + begN;
  i := ins;
  Label1.Caption := 'Количество попыток :' + IntToStr( i );
  EditNumber.Enabled := True;
  ButOK.Enabled := True;
  EditNumber.Clear;
  Label4.Caption:='';
end;


end.

