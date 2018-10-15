unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls;

type

  { TForm1 }
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    RB_1_1_i: TImage;
    Label1: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Memo5: TMemo;
    Memo6: TMemo;
    Memo7: TMemo;
    Memo8: TMemo;
    Memo9: TMemo;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    RB_1_1: TRadioButton;
    RB_2_1_i: TImage;
    RB_3_1_i: TImage;
    RB_4_1_i: TImage;
    RB_5_1_i: TImage;
    RB_6_1_i: TImage;
    RB_7_1_i: TImage;
    RB_8_1_i: TImage;
    RB_8_2_i: TImage;
    RB_8_3_i: TImage;
    RB_8_4_i: TImage;
    RB_7_2_i: TImage;
    RB_7_3_i: TImage;
    RB_7_4_i: TImage;
    RB_6_2_i: TImage;
    RB_6_3_i: TImage;
    RB_6_4_i: TImage;
    RB_5_2_i: TImage;
    RB_5_3_i: TImage;
    RB_5_4_i: TImage;
    RB_4_2_i: TImage;
    RB_4_3_i: TImage;
    RB_4_4_i: TImage;
    RB_3_2_i: TImage;
    RB_3_3_i: TImage;
    RB_3_4_i: TImage;
    RB_2_2_i: TImage;
    RB_2_3_i: TImage;
    RB_2_4_i: TImage;
    RB_1_2_i: TImage;
    RB_1_3_i: TImage;
    RB_1_4_i: TImage;
    RB_5_3: TRadioButton;
    RB_5_2: TRadioButton;
    RB_5_1: TRadioButton;
    RB_6_4: TRadioButton;
    RB_6_3: TRadioButton;
    RB_6_2: TRadioButton;
    RB_6_1: TRadioButton;
    RB_7_4: TRadioButton;
    RB_7_3: TRadioButton;
    RB_7_2: TRadioButton;
    RB_7_1: TRadioButton;
    RB_8_4: TRadioButton;
    RB_8_3: TRadioButton;
    RB_8_2: TRadioButton;
    RB_8_1: TRadioButton;
    RB_3_3: TRadioButton;
    RB_3_2: TRadioButton;
    RB_3_1: TRadioButton;
    RB_1_2: TRadioButton;
    RB_1_3: TRadioButton;
    RB_1_4: TRadioButton;
    RB_2_4: TRadioButton;
    RB_2_3: TRadioButton;
    RB_2_2: TRadioButton;
    RB_2_1: TRadioButton;
    RB_3_4: TRadioButton;
    RB_4_4: TRadioButton;
    RB_4_3: TRadioButton;
    RB_4_2: TRadioButton;
    RB_4_1: TRadioButton;
    RB_5_4: TRadioButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    function CheckOtv(a, b, c, d  : TRadioButton) : Boolean;
    procedure Otv(a, b, c, d, otv : TRadioButton; i : Integer);

  private

  public

  end;

var
  Form1: TForm1;
  Count : Integer;    // хранит количество правильных ответов

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Button1.Visible := false;
  Button2.Visible := true;
  PageControl1.Visible := true;
  Count := 0;
end;

//////////////////////////////////////////////////////////
/// Данная функция проверяет, дан ли ответ на вопросов ///
//////////////////////////////////////////////////////////
function TForm1.CheckOtv(a, b, c, d : TRadioButton) : Boolean;
var
  bool : Boolean;
begin
  if ((a.Checked)or (b.Checked)or(c.Checked)or(d.Checked)) then
    bool := True else bool := False;
  Result := bool;
end;

///////////////////////////////////////////////////////////////////
///     Процедура устанавливает иконку возле варианта ответа    ///
///////////////////////////////////////////////////////////////////
procedure TForm1.Otv(a, b, c, d, otv : TRadioButton; i : Integer);
begin
  if (otv.Checked) then
  begin
    (FindComponent( otv.Name +'_i' ) as TImage).Picture.LoadFromFile('da.png');
    Memo1.Lines.Add('Вы ответили верно на '+IntToStr(i)+' вопрос');
    Inc( Count );
  end else
  begin
    Memo1.Lines.Add('Вы ответили неверно на '+IntToStr(i)+' вопрос');
    if (a.Checked) then  (FindComponent( a.Name +'_i' ) as TImage).Picture.LoadFromFile('net.png') else
    if (b.Checked) then  (FindComponent( b.Name +'_i' ) as TImage).Picture.LoadFromFile('net.png') else
    if (c.Checked) then  (FindComponent( c.Name +'_i' ) as TImage).Picture.LoadFromFile('net.png') else
    if (d.Checked) then  (FindComponent( d.Name +'_i' ) as TImage).Picture.LoadFromFile('net.png');
  end;

  a.Enabled:= false;
  b.Enabled:= false;
  c.Enabled:= false;
  d.Enabled:= false;
end;

/////////////////////////////////////////////////////////////
///       Проверка теста, кнопка "Завершить"              ///
/////////////////////////////////////////////////////////////
procedure TForm1.Button2Click(Sender: TObject);
var
  a : Array[1..8] of Boolean;
  i : Integer;
  b : Boolean;
begin
  b := true;
  Memo1.Clear;

  // Проверяем, на какие вопросы даны ответы
  a[1]:= CheckOtv(RB_1_1, RB_1_2, RB_1_3, RB_1_4);
  a[2]:= CheckOtv(RB_2_1, RB_2_2, RB_2_3, RB_2_4);
  a[3]:= CheckOtv(RB_3_1, RB_3_2, RB_3_3, RB_3_4);
  a[4]:= CheckOtv(RB_4_1, RB_4_2, RB_4_3, RB_4_4);
  a[5]:= CheckOtv(RB_5_1, RB_5_2, RB_5_3, RB_5_4);
  a[6]:= CheckOtv(RB_6_1, RB_6_2, RB_6_3, RB_6_4);
  a[7]:= CheckOtv(RB_7_1, RB_7_2, RB_7_3, RB_7_4);
  a[8]:= CheckOtv(RB_8_1, RB_8_2, RB_8_3, RB_8_4);

  for i:= 1 to 8 do
    if a[i] = False then
    begin
      Memo1.Clear;
      b := false;
      ShowMessage('Не на все вопросы даны ответы!!!');
      Break;
    end;

  // Если на все вопросы даны ответы,
  // то проверяем правильность ответа
  if ( b = true) then begin
    Otv(RB_1_1, RB_1_2, RB_1_3, RB_1_4, RB_1_3, 1);
    Otv(RB_2_1, RB_2_2, RB_2_3, RB_2_4, RB_2_2, 2);
    Otv(RB_3_1, RB_3_2, RB_3_3, RB_3_4, RB_3_3, 3);
    Otv(RB_4_1, RB_4_2, RB_4_3, RB_4_4, RB_4_3, 4);
    Otv(RB_5_1, RB_5_2, RB_5_3, RB_5_4, RB_5_2, 5);
    Otv(RB_6_1, RB_6_2, RB_6_3, RB_6_4, RB_6_2, 6);
    Otv(RB_7_1, RB_7_2, RB_7_3, RB_7_4, RB_7_3, 7);
    Otv(RB_8_1, RB_8_2, RB_8_3, RB_8_4, RB_8_1, 8);

    Memo1.Lines.Add('Количество правильных ответов: ' + IntToStr(Count));
  end;

end;

end.

