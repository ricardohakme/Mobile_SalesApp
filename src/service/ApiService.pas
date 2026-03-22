unit ApiService;

interface

uses
  System.SysUtils;

type
  TApiService = class
  public
    function SendOrder(ClientName: string): Boolean;
  end;

implementation

function TApiService.SendOrder(ClientName: string): Boolean;
begin
  // Simulação de envio para API
  Sleep(500);
  Result := True;
end;

end.
