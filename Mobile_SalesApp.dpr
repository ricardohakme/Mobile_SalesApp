program Mobile_SalesApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  ApiService in 'src\service\ApiService.pas',
  Client in 'src\model\Client.pas',
  ClientViewModel in 'src\viewmodel\ClientViewModel.pas',
  MainForm in 'src\view\MainForm.pas' {frMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrMain, frMain);
  Application.Run;
end.
