unit ClientViewModel;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, Client, System.JSON, System.IOUtils;

type
  TClientViewModel = class
  private
    FClients: TObjectList<TClient>;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadFromJSON(FileName: string);
    function GetClients: TObjectList<TClient>;
  end;

implementation

{ TClientViewModel }

constructor TClientViewModel.Create;
begin
  FClients := TObjectList<TClient>.Create;
  // Carrega o JSON com clientes fakes
  LoadFromJSON('clients.json');
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

procedure TClientViewModel.LoadFromJSON(FileName: string);
var
  JSONData: string;
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
  Client: TClient;
  I: Integer;
begin
  FClients.Clear;

  if not FileExists(FileName) then
    Exit;

  JSONData := TFile.ReadAllText(FileName, TEncoding.UTF8);
  JSONArray := TJSONObject.ParseJSONValue(JSONData) as TJSONArray;
  if JSONArray = nil then Exit;

  try
    for I := 0 to JSONArray.Count - 1 do
    begin
      JSONObject := JSONArray.Items[I] as TJSONObject;
      Client := TClient.Create;
      Client.Id := JSONObject.GetValue<Integer>('id');
      Client.Name := JSONObject.GetValue<string>('name');
      FClients.Add(Client);
    end;
  finally
    JSONArray.Free;
  end;
end;

end.
