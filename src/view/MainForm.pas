unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, ApiService,
  ClientViewModel, FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation,
  FMX.StdCtrls, Client, FMX.Edit, FMX.Objects;

type
  TS = class(TForm)
    tbMain: TToolBar;
    lblTitle: TLabel;
    S: TLayout;
    lstClients: TListBox;
    txtSearchClient: TEdit;
    Rectangle1: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    btnSendOrder: TButton;
    btnHistory: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSendOrderClick(Sender: TObject);
    procedure txtSearchClientChange(Sender: TObject);
    procedure btnHistoryClick(Sender: TObject);
  private
    { Private declarations }
    FViewModel: TClientViewModel;
    FApiService: TApiService;
    procedure LoadClients(Filter: string = '');
  public
    { Public declarations }
  end;

var
  S: TS;

implementation

{$R *.fmx}

{ TfrMain }

procedure TS.btnHistoryClick(Sender: TObject);
begin
  ShowMessage('Histórico de pedidos não implementado (exemplo para portfólio).');
end;

procedure TS.btnSendOrderClick(Sender: TObject);
begin
  if lstClients.ItemIndex < 0 then
    Exit;

  if FApiService.SendOrder(lstClients.Items[lstClients.ItemIndex]) then
    ShowMessage('Pedido enviado com sucesso!');
end;

procedure TS.FormCreate(Sender: TObject);
  procedure SetToolbarColor(TB: TToolBar; Color: TAlphaColor);
  var
    Obj: TFmxObject;
  begin
    TB.ApplyStyleLookup;
    for Obj in TB.Children do
    begin
      if Obj is TRectangle then
      begin
        TRectangle(Obj).Fill.Color := Color;
        Break;
      end;
    end;
  end;
begin
  FViewModel := TClientViewModel.Create;
  FApiService := TApiService.Create;
  LoadClients;

  // -------------------------------
  // Cores gerais
  // -------------------------------

  // Form background
  Self.Fill.Color := TAlphaColorRec.Lightgray; // cinza claro

  // ToolBar
  SetToolbarColor(tbMain, TAlphaColorRec.Dodgerblue);
  lblTitle.TextSettings.FontColor := TAlphaColorRec.White;
  lblTitle.TextSettings.Font.Size := 16;
  lblTitle.TextSettings.Font.Style := [TFontStyle.fsBold];
end;

procedure TS.LoadClients(Filter: string = '');
var
  Client: TClient;
begin
  lstClients.Items.Clear;

  for Client in FViewModel.GetClients do
    if (Filter = '') or (Client.Name.ToLower.Contains(Filter.ToLower)) then
      lstClients.Items.Add(Client.Name);
end;

procedure TS.txtSearchClientChange(Sender: TObject);
begin
 LoadClients(txtSearchClient.Text);
end;

end.
