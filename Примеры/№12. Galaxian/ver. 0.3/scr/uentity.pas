unit uEntity;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

type

  { TEntity }

  TEntity = class
  protected
    img           : TBitmap;
    xPos, yPos    : Integer;
    Width, Height : Integer;
    isVisable     : Boolean;
  public
    constructor Create( image: string );
    procedure   SetPosition( x, y : Integer );
    procedure   SetVisable ( visable : Boolean );

    function GetImage : TBitmap;
    function GetVisable : Boolean;
    function GetPosX  : Integer;
    function GetPosY  : Integer;
    function GetWidth : Integer;
    function GetHeight: Integer;
  end;

implementation

{ TEntity }

constructor TEntity.Create(image: string);
begin
  Self.img := TBitmap.Create;
  Self.img.LoadFromFile( image );
  Self.Height := Self.img.Height;
  Self.Width  := Self.img.Width;
  Self.isVisable := True;
end;

procedure TEntity.SetPosition(x, y: Integer);
begin
  Self.xPos := x;
  Self.yPos := y;
end;

procedure TEntity.SetVisable(visable: Boolean);
begin
  Self.isVisable := visable;
end;

function TEntity.GetImage: TBitmap;
begin
  Result := Self.img;
end;

function TEntity.GetVisable: Boolean;
begin
  Result := Self.isVisable;
end;

function TEntity.GetPosX: Integer;
begin
  Result := Self.xPos;
end;

function TEntity.GetPosY: Integer;
begin
  Result := Self.yPos;
end;

function TEntity.GetWidth: Integer;
begin
  Result := Self.Width;
end;

function TEntity.GetHeight: Integer;
begin
  Result := Self.Height;
end;

end.

