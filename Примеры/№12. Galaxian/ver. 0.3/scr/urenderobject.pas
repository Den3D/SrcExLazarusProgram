unit uRenderObject;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uEntity, Graphics;

type

  { TRenderObject }

  TRenderObject = class
  private
    _Canvas: TCanvas;
  public
    constructor Create ( canvas: TCanvas);
    procedure Draw( obj: TEntity );
  end;

implementation

{ TRenderObject }

constructor TRenderObject.Create(canvas: TCanvas);
begin
  _Canvas := canvas;
end;

procedure TRenderObject.Draw(obj: TEntity);
begin
  _Canvas.Draw( obj.GetPosX, obj.GetPosY, obj.GetImage );
end;

end.

