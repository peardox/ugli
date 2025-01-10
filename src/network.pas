unit Network;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Generics.Collections;

type
  TSteamAppItem = Class
  private
    FAppId: Int64;
    FName: String;
  public
    constructor Create(const AKey: Int64; AValue: String);
    property AppId: Int64 read FAppId write FAppId;
    property Name: String read FName write FName;
  end;

  TSteamApps = specialize TObjectList<TSteamAppItem>;

function ReadApplist: TSteamApps;

implementation

uses
  dialogs,
  fpjson,
  jsonparser,
  fphttpclient,
  opensslsockets;

constructor TSteamAppItem.Create(const AKey: Int64; AValue: String);
begin
  FAppId := AKey;
  FName := AValue;
end;

function ReadApplist: TSteamApps;
var
   Dict: TSteamApps;
   S, V: String;
   C: TFPHttpClient;
   Val, J, D: TJSONData;
   K, cnt, idx: Integer;
   Item: TSteamAppItem;
begin
  S := '';
  Dict := Nil;
  C := TFPHttpClient.Create(Nil);
  try
    S := C.Get('https://api.steampowered.com/ISteamApps/GetAppList/v2/');
    J := GetJSON(S);
    D := J.FindPath('applist.apps');
    cnt := D.Count;
    Dict := TSteamApps.Create;
    for idx := 0 to cnt - 1 do
      begin
        Val := D.Items[idx];
        K := Val.FindPath('appid').AsInt64;
        V := Val.FindPath('name').AsString;
        Item := TSteamAppItem.Create(K, V);
        Dict.Add(Item);
      end;
  finally
    C.Free;
  end;
  Result := Dict;
end;


end.

