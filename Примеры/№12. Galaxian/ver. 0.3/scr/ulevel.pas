unit uLevel;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, FileUtil, Generics.Collections,
  uPlayer, uEnemy, uResourceManager;

type
  TPlayerNode = class
    ID    : String[20];
    Res_ID: String[20];
    Health: Integer;
    PosX  : Integer;
    PosY  : Integer;
  end;

type
  TEnemyNode = class
    ID    : String[20];
    Res_ID: String[20];
    Health: Integer;
    PosX  : Integer;
    PosY  : Integer;
  end;

type
  TListPlayer = specialize TList<TPlayer>;
  TListEnemy  = specialize TList<TEnemy>;


type

  { TLevel }

  TLevel = class
  private
    ListPlayers  : TList;
    ListEnemys   : TList;

    jRoot        : TJSONData;
    _name        : String;
    _countPlayer :Integer;
    _countEnemy  :Integer;
    _ResManager  : TResourceManager;
  public
    property Name       : String read _name write _name;
    property CountPlayer: Integer read _countPlayer write _countPlayer;
    property CountEnemy : Integer read _countEnemy write _countEnemy;

  public
    constructor Create( ResManager : TResourceManager );
    destructor Destroy; override;
    procedure Load( filename : String);

    function GetListPlayer(): TListPlayer;
    function GetPlayer( index: Integer ): TPlayer;

    function GetListEnemy(): TListEnemy;
    function GetEnemy( index: Integer ): TEnemy;
  private
    procedure LoadNodeResource( node: TJSONArray );
    procedure LoadNodeLevels( node: TJSONData );
  end;


implementation

{ TLevel }
// Конструктор
constructor TLevel.Create(ResManager: TResourceManager);
begin
  _ResManager := ResManager;
  ListPlayers := TList.Create();
  ListEnemys  := TList.Create();
end;

// Деструктор
destructor TLevel.Destroy;
begin
  FreeAndNil(ListPlayers);
  FreeAndNil(ListEnemys);
  FreeAndNil(jRoot);
  inherited Destroy;
end;

// Загрузка уровня
procedure TLevel.Load(filename: String);
var
  jResources  : TJSONArray;
  jLevel      : TJSONData;
begin
  // загркзка файла уровня
  jRoot := GetJSON(ReadFileToString( filename ));

  jResources := TJSONArray( jRoot.FindPath('resources') );
  LoadNodeResource( jResources );

  jLevel := jRoot.FindPath('level');
  LoadNodeLevels( jLevel );

end;

// Вернуть список TPlayer
function TLevel.GetListPlayer: TListPlayer;
var
  playList: TListPlayer;
  play: TPlayer;
  str_res: String;
  i: Integer;
begin
  playList := TListPlayer.Create();

  for i:= 0 to CountPlayer - 1 do begin
    str_res := TPlayerNode(ListPlayers[i]).Res_ID;
    play := TPlayer.Create( _ResManager.ResourceList[ str_res ].Files );
    play.SetPosition( TPlayerNode(ListPlayers[i]).PosX,
                      TPlayerNode(ListPlayers[i]).PosY );
    play.Health := TPlayerNode(ListPlayers[i]).Health;
    playList.Add( play );
  end;

  Result := playList;
end;

// Вернуть TPlayer по индексу
function TLevel.GetPlayer(index: Integer): TPlayer;
var
  play: TPlayer;
  str_res: String;
begin
  str_res := TPlayerNode(ListPlayers[index]).Res_ID;
  play := TPlayer.Create( _ResManager.ResourceList[ str_res ].Files );
  play.SetPosition( TPlayerNode(ListPlayers[index]).PosX,
                    TPlayerNode(ListPlayers[index]).PosY );
  play.Health := TPlayerNode(ListPlayers[index]).Health;

  Result := play;
end;

// Вернуть список TEnemy
function TLevel.GetListEnemy: TListEnemy;
var
  enemyList: TListEnemy;
  enemy: TEnemy;
  str_res: String;
  i: Integer;
begin
  enemyList := TListEnemy.Create();

  for i:= 0 to CountEnemy - 1 do begin
    str_res := TEnemyNode(ListEnemys[i]).Res_ID;
    enemy := TEnemy.Create( _ResManager.ResourceList[ str_res ].Files,
                           TEnemyNode(ListEnemys[i]).PosX,
                           TEnemyNode(ListEnemys[i]).PosY );
    enemy.Health := TEnemyNode(ListEnemys[i]).Health;
    enemyList.Add( enemy );
  end;

  Result := enemyList;
end;

// Вернуть TEnemy по индексу
function TLevel.GetEnemy(index: Integer): TEnemy;
var
  enemy: TEnemy;
  str_res: String;
begin
  str_res := TEnemyNode(ListEnemys[index]).Res_ID;
  enemy := TEnemy.Create( _ResManager.ResourceList[ str_res ].Files,
                          TEnemyNode(ListEnemys[index]).PosX,
                          TEnemyNode(ListEnemys[index]).PosY );
  enemy.Health := TEnemyNode(ListEnemys[index]).Health;

  Result := enemy;
end;

// Загрузить блок  resources из файла
procedure TLevel.LoadNodeResource(node: TJSONArray);
var
  i   : Integer;
  res : TResourceNode;
begin
  for i := 0 to node.Count-1 do begin
    res := TResourceNode.Create;
    res.ID    := node[i].FindPath('id').AsString;
    res.Types := node[i].FindPath('type').AsString;
    res.Files := node[i].FindPath('file').AsString;
    if not( _ResManager.IsResource(res.ID)) then
      _ResManager.ResourceList.Add(res.ID, res)
    else
      _ResManager.ResourceList[res.ID] := res;
  end;
end;

// Загрузить блок  level из файла
procedure TLevel.LoadNodeLevels(node: TJSONData);
var
  Arr  : TJSONArray;
  play : TPlayerNode;
  enem : TEnemyNode;
  i : Integer;
begin
  // Очистка списков
  ListPlayers.Clear;
  ListEnemys.Clear;

  // Название уровня
  Name := node.FindPath('name').AsString;

  // Создание списка игроков (TPlayerNode)
  Arr := TJSONArray(node.FindPath('players'));
  CountPlayer := Arr.Count;
  for i := 0 to CountPlayer - 1 do begin
    play := TPlayerNode.Create;
    play.ID     := Arr[i].FindPath('id').AsString;
    play.Res_ID := Arr[i].FindPath('res_id').AsString;
    play.Health := Arr[i].FindPath('health').AsInteger;
    play.PosX   := Arr[i].FindPath('position.x').AsInteger;
    play.PosY   := Arr[i].FindPath('position.y').AsInteger;
    ListPlayers.Add( play );
  end;


  // Создание списка врагов (TEnemyNode)
  Arr := TJSONArray(node.FindPath('enemys'));
  CountEnemy := Arr.Count;
  for i := 0 to CountEnemy - 1 do begin
    enem := TEnemyNode.Create;
    enem.ID     := Arr[i].FindPath('id').AsString;
    enem.Res_ID := Arr[i].FindPath('res_id').AsString;
    enem.Health := Arr[i].FindPath('health').AsInteger;
    enem.PosX   := Arr[i].FindPath('position.x').AsInteger;
    enem.PosY   := Arr[i].FindPath('position.y').AsInteger;
    ListEnemys.Add( enem );
  end;
end;

end.






