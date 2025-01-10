program Ugli;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFMX in 'src\MainFMX.pas' {Form1},
  fileutils in 'src\fileutils.pas',
  network in 'src\network.pas',
  winutils in 'src\winutils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
