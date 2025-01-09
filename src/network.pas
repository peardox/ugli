unit Network;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

function ReadURLGet(url:string):string;

implementation

uses fphttpclient;

function ReadURLGet(url:string):string;
begin
{
with TFPHTTPClient.Create(nil) do
try
  Result := Get(url);
finally
  Free;
}
end;


end.

