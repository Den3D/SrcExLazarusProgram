unit uLogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { TFLogin }

  TFLogin = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private

  public

  end;

var
  FLogin: TFLogin;

implementation
  uses Unit1;
{$R *.lfm}

  { TFLogin }

  procedure TFLogin.BitBtn1Click(Sender: TObject);
  begin
    Form1.Close;
  end;

procedure TFLogin.BitBtn2Click(Sender: TObject);
begin
  if ((Edit1.Text = 'admin') and (Edit2.Text = 'admin')) then
  begin
    Form1.b:= true;
    Form1.Visible:=true;
    Close;
  end else
    ShowMessage('Введен неверный логин или пароль!!!');
end;

end.

