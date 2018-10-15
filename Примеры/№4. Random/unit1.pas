unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

// Проверка на присутствие числа в массиве
function isThere(a:array of Integer; n : Integer; x : Integer) : Boolean;
var
  i : Integer;
  b : Boolean;
begin
  for i:= 1 to n do
   if a[i] = x then begin b:= true; Break; end else  b:= false;
  Result := b;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  a, b, n : Integer;
  i, temp : Integer;
  arr: Array of Integer;
  str : String;
  bool : Boolean;

begin
  Memo1.Clear;
  n := StrToInt(Edit1.Text);
  a := StrToInt(Edit2.Text);
  b := StrToInt(Edit3.Text);

  if (( a<b )and(n<=(b-a)+1)) then begin
    SetLength(arr, n+1);
    Randomize;
    for i :=  1 to n do begin

     bool:=true;
     while (bool = true) do begin
      temp := Random(b-a+1) + a;
      bool := isThere(arr, i, temp);

      if (bool = False) then
      begin
        arr[i] := temp;
        str := Memo1.Text;
      end;
     end;


    Memo1.Text:= str + IntToStr(arr[i]) + ' ';

   end; // for

  end else ShowMessage('Error! Одно из условий не выполняется!');


end;

end.

