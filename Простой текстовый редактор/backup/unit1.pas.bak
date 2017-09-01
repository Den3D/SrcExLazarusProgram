unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    FontDialog1: TFontDialog;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  FileWork: String;

implementation

{$R *.lfm}

Procedure SaveAs;
begin
 If Form1.SaveDialog1.Execute then
 begin
 Form1.Memo1.Lines.SaveToFile(Form1.SaveDialog1.FileName);
 FileWork:=Form1.SaveDialog1.FileName;
 end;
end;

{ TForm1 }

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  Memo1.CutToClipboard;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
   Close;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
begin
 Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
 FileWork:=OpenDialog1.FileName;
end;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  If FileWork='' then SaveAs else Memo1.Lines.SaveToFile(FileWork);
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  SaveAs;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  FileWork:='';
  Memo1.Clear;
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  Memo1.CopyToClipboard;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  Memo1.PasteFromClipboard;
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin
If Memo1.WordWrap then
 begin
 Memo1.WordWrap:=false;
 Memo1.ScrollBars:=ssBoth;
 MenuItem12.Checked:=False;
 end
 else
 begin
 Memo1.WordWrap:=True;
 Memo1.ScrollBars:=ssVertical;
 MenuItem12.Checked:=True;
 end;
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
begin
  if FontDialog1.Execute then Memo1.Font:=FontDialog1.Font;
end;

end.

