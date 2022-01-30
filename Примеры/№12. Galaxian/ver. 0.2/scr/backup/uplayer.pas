unit uPlayer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uEntity;

type

  { TPlayer }

  TPlayer = class(TEntity)
  public
    constructor Create(image: string);
    constructor Create(image: string; x, y: Integer);

    procedure Move ( step: Integer );
  end;

implementation

{ TPlayer }

constructor TPlayer.Create(image: string);
begin


end;

constructor TPlayer.Create(image: string; x, y: Integer);
begin
  // вызов конструктора базового класса
  inherited Create( image );
  Self.SetPosition(x, y);
end;

procedure TPlayer.Move(step: Integer);
begin
  Self.xPos := Self.xPos + step;
end;

end.

