unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure MyTimer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  todeyDate : TDateTime;
  todeyTime : TDateTime;
  st : TSystemTime;

  Start : Double;
  b : Boolean;

implementation

{$R *.lfm}

{ TForm1 }


function GetTime : TDateTime;
var
  s : TSystemTime;
begin
  GetLocalTime(s);
  Result := SystemTimeToDateTime(s);
end;

procedure TForm1.MyTimer(Sender: TObject);
begin

 todeyTime := Time;
 Label2.Caption:= TimeToStr(todeyTime);

 GetLocalTime(st);
 Label3.Caption := 'Часы:'+IntToStr(st.wHour)+ ' Минуты:'+IntToStr(st.wMinute)+' Сек.:'+IntToStr(st.wSecond)+' Милесек.:'+IntToStr(st.wMilliseconds);

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin

 if not ( b ) then
   Start:= GetTime;

 b := True;

 Label4.Caption:= FormatDateTime('hh:nn:ss zzz',GetTime - Start);

end;




procedure TForm1.FormCreate(Sender: TObject);
begin
 todeyTime := Time;
 todeyDate := Date;

 Label1.Caption:= DateToStr(todeyDate);
 Label2.Caption:= TimeToStr(todeyTime);



end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  b := false;
  Timer2.Enabled :=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   Timer2.Enabled :=false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

 MyTimer(Sender);

end;

end.

