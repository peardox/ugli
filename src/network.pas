unit Network;

{$ifdef fpc}
{$mode ObjFPC}{$H+}
{$endif}


interface

uses
  Classes, SysUtils,
{$ifdef fpc}
  Generics.Collections
{$else}
  System.Generics.Collections, System.Net.HttpClient
{$endif}
  ;

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


 TSteamApps = {$ifdef fpc}specialize {$endif}TObjectList<TSteamAppItem>;


function ReadApplist: TSteamApps;

implementation

uses
{$ifdef fpc}
  fpjson,
  jsonparser,
  fphttpclient,
  opensslsockets
{$else}
  System.JSON
{$endif}
  ;

constructor TSteamAppItem.Create(const AKey: Int64; AValue: String);
begin
  FAppId := AKey;
  FName := AValue;
end;

function ReadApplist: TSteamApps;
var
   Dict: TSteamApps;
   S, V: String;
   C: THTTPClient;
   R: IHTTPResponse;
   {
   C: TFPHttpClient;
   Val, J, D: TJSONData;
   K, cnt, idx: Integer;
   }
   Item: TSteamAppItem;
begin
  S := '';
  Dict := Nil;
  C := THttpClient.Create;
  try
    R := C.Get('https://api.steampowered.com/ISteamApps/GetAppList/v2/');
    S := R.ContentAsString();
    {
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
      }
  finally
    C.Free;
  end;
  Result := Dict;
end;


end.

