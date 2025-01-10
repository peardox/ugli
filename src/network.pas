unit Network;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

function ReadApplist:string;

implementation

uses
  fphttpclient,
  opensslsockets;

function ReadApplist:string;
var
   S: String;
   C: TFPHttpClient;
begin
  S := '';
  C := TFPHttpClient.Create(Nil);
  try
    S := C.Get('https://api.steampowered.com/ISteamApps/GetAppList/v2/');
  finally
    C.Free;
  end;
  Result := S;
end;


end.

