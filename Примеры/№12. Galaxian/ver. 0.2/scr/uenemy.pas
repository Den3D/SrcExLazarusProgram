unit uEnemy;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uEntity;

type

  { TEnemy }

  TEnemy = class(TEntity)
  private
    _health : Integer;
  public
    constructor Create(image: string);
    constructor Create(image: string; x, y: Integer);
    procedure Move ( step: Integer );
    procedure Damage ( n : Integer );
    property Health: Integer read  _health write _health;
  end;

implementation

{ TEnemy }

constructor TEnemy.Create(image: string);
begin
  Self.Create( image, 0, 0);
end;

constructor TEnemy.Create(image: string; x, y: Integer);
begin
  // вызов конструктора базового класса
  inherited Create( image );
  Self.SetPosition(x, y);
  Self.Health := 3;
end;

procedure TEnemy.Move(step: Integer);
begin
 //
end;

procedure TEnemy.Damage(n: Integer);
begin
  Self.Health := Self.Health - n;
end;

end.

