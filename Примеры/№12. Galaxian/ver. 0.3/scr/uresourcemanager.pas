unit uResourceManager;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, FileUtil, Generics.Collections;

type
  TResourceNode = class
    ID    : String[20];
    Types : String[20];
    Files : String[255];
  end;

type
  TDictionaryResource = specialize TDictionary<String, TResourceNode>;

type

  { TResourceManager }

  TResourceManager = class
  public
    ResourceList: TDictionaryResource;
  public
    constructor Create( filename: String );
    destructor Destroy; override;
    procedure AddResource(key: String; res : TResourceNode);
    function GetResource(key: string): string;
    function GetTypeResource(key: string): string;
    function IsResource(key: string ): Boolean;
  private
    procedure Load( filename: String );

  end;

implementation

{ TResourceManager }

// Конструктор
constructor TResourceManager.Create(filename: String);
begin
  ResourceList := TDictionaryResource.Create();
  Load( filename );
end;

// Деструктор
destructor TResourceManager.Destroy;
begin
  FreeAndNil( ResourceList );
  inherited Destroy;
end;

// Добавление элемента в ресурс
procedure TResourceManager.AddResource(key: String; res : TResourceNode);
begin
  ResourceList.Add( key, res );
end;

// Получить файл ресурса по его ключу
function TResourceManager.GetResource( key: string ): string;
begin
  Result := ResourceList[key].Files;
end;

// Получить тип ресурса по его ключу
function TResourceManager.GetTypeResource(key: string): string;
begin
  Result := ResourceList[key].Types;
end;

// Проверка наличия рескрса в списке
function TResourceManager.IsResource( key: string ): Boolean;
var
  flag : Boolean;
  sKey : String;
begin
  flag := False;
  for sKey in ResourceList.Keys do
    if sKey = key then begin
      flag := True;
      Break;
    end;
  Result := flag;
end;

// Загрузка файла ресурсов
procedure TResourceManager.Load(filename: String);
var
  jRoot      : TJSONData;
  jResources : TJSONArray;
  res        : TResourceNode;
  i          : Integer;
begin
  jRoot := GetJSON( ReadFileToString( filename ) );

  jResources := TJSONArray( jRoot.FindPath('resources') );

  for i := 0 to jResources.Count - 1  do begin
    res := TResourceNode.Create;
    res.ID    := jResources[i].FindPath('id').AsString;
    res.Types := jResources[i].FindPath('type').AsString;
    res.Files := jResources[i].FindPath('file').AsString;
    // ResourceList.Add( res.ID, res );
    AddResource( res.ID, res );
  end;

  FreeAndNil( jRoot );
end;

end.




