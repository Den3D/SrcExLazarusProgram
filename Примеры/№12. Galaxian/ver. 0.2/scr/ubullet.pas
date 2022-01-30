unit uBullet;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uEntity;

type

  { TBullet }

  TBullet = class(TEntity)
  public
    constructor Create(image: string);
    constructor Create(image: string; x, y: Integer);
    function Collision ( entity : TEntity ): Boolean;
    procedure Move ( step: Integer );
  end;

implementation

{ TBullet }

constructor TBullet.Create(image: string);
begin
  Self.Create( image, 0, 0);
end;

constructor TBullet.Create(image: string; x, y: Integer);
begin
   // вызов конструктора базового класса
  inherited Create( image );
  Self.SetPosition(x, y);
end;

function TBullet.Collision(entity: TEntity): Boolean;
begin
 if (Self.GetPosY < (entity.GetPosY + entity.GetHeight)) and
    (Self.GetPosY > (entity.GetPosY)) and
    (Self.GetPosX > (entity.GetPosX)) and
    (Self.GetPosX < (entity.GetPosX + entity.GetWidth)) and
    (Self.GetVisable) then Result := True else Result := False;
end;

procedure TBullet.Move(step: Integer);
begin
  Self.yPos := Self.yPos + step;
end;

end.

