unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    function MyReplace(BaseStr, str, str2 : String) : String;
    function MyReplaceAll(BaseStr, str, str2 : String) : String;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  s1,s2,s3, ts : String;

begin
   s1 := Memo1.Text;
   s2 := ' www ';
   s3 := ' zzz ';
   ts := MyReplace(s1,s2,s3);
   Memo1.Text:=ts;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  s1,s2,s3, ts : String;

begin
   s1 := Memo1.Text;
   s2 := ' www ';
   s3 := ' zzz ';
   ts := MyReplaceAll(s1,s2,s3);
   Memo1.Text:=ts;

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  s1,s2,s3, ts : String;

begin
   s1 := Memo1.Text;
   s2 := ' www ';
   s3 := ' zzz ';
   ts := StringReplace(s1, s2, s3, [RFReplaceAll, rfIgnoreCase]);
   Memo1.Text:=ts;

end;

procedure TForm1.Memo1Change(Sender: TObject);
var
  s1,s2,s3, ts : String;
  i : Integer;
begin
   s1 := Memo1.Text;
   s2 := ' www ';
   s3 := ' zzz ';
   i := Memo1.SelStart;
   ts := StringReplace(s1, s2, s3, [RFReplaceAll, rfIgnoreCase]);
   Memo1.Text:=ts;
   Memo1.SelStart := i;

end;

function TForm1.MyReplace(BaseStr, str, str2: String): String;
var
   i : Integer;
begin
   i := Pos(str, BaseStr);
   if ( i>0 ) then begin
    Delete(BaseStr, i, Length(str));
    Insert(str2, BaseStr, i);
   end;

   Result := BaseStr;
end;

function TForm1.MyReplaceAll(BaseStr, str, str2: String): String;
var
   i : Integer;
begin
   i := Pos(str, BaseStr);
   while ( i>0) do
   if ( i>0 ) then begin
    Delete(BaseStr, i, Length(str));
    Insert(str2, BaseStr, i);
     i := Pos(str, BaseStr);
   end;

   Result := BaseStr;
end;

end.

