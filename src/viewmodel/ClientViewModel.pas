unit ClientViewModel;

interface

uses
  System.Generics.Collections, Client;

type
  TClientViewModel = class
  private
    FClients: TObjectList<TClient>;
  public
    constructor Create;
    destructor Destroy; override;

    function GetClients: TObjectList<TClient>;
  end;

implementation

constructor TClientViewModel.Create;
var
  Client: TClient;
begin
  FClients := TObjectList<TClient>.Create;

  // Dados mockados
  Client := TClient.Create;
  Client.Id := 1;
  Client.Name := 'Cliente A';
  FClients.Add(Client);

  Client := TClient.Create;
  Client.Id := 2;
  Client.Name := 'Cliente B';
  FClients.Add(Client);
end;

destructor TClientViewModel.Destroy;
begin
  FClients.Free;
  inherited;
end;

function TClientViewModel.GetClients: TObjectList<TClient>;
begin
  Result := FClients;
end;

end.
