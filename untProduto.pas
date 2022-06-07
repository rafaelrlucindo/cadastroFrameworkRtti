unit untProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPadrao, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.WinXPickers, untClassProduto, untDaoGenerico, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils, dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxCurrencyEdit, untClassFornecedor, untFornecedor,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmProduto = class(TfrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    edtID: TEdit;
    edtDescricao: TEdit;
    edtSTATUS: TComboBox;
    edtPreco_Unitario: TcxCurrencyEdit;
    Label3: TLabel;
    edtNomeFornecedorIgnore: TEdit;
    Label5: TLabel;
    edtIdFornecedor: TEdit;
    procedure btnSalvarClick(Sender: TObject);
    procedure cdsPadraoAfterScroll(DataSet: TDataSet);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtIdFornecedorChange(Sender: TObject);
    procedure edtIdFornecedorDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProduto: TfrmProduto;

implementation

uses
  System.Rtti,  cxFormats;

{$R *.dfm}

procedure TfrmProduto.btnBuscarClick(Sender: TObject);
  var
    tmpEvento : TNotifyEvent;
begin
  try
    FObjeto := TProduto.Create;
    FCampoBusca := 'DESCRICAO';
    dbgPadrao.Columns[0].FieldName := FCampoBusca;
    tmpEvento := edtIdFornecedor.OnChange;
    edtIdFornecedor.OnChange := nil;

    inherited;
  finally
    FObjeto.Free;
  end;

  edtIdFornecedor.OnChange := tmpEvento;
  edtIdFornecedorChange(Sender);
end;

procedure TfrmProduto.btnExcluirClick(Sender: TObject);
begin
  try
    FObjeto := TProduto.Create;
    inherited;
  finally
    FreeAndNil(FObjeto);
  end;
end;

procedure TfrmProduto.btnSalvarClick(Sender: TObject);
begin
  try
    FObjeto := TProduto.Create;

    if (edtDescricao.Text = '') or (edtSTATUS.ItemIndex < 0)
      or (edtPreco_Unitario.Text = '') or (vazio(edtIdFornecedor.Text)) then
      begin
        Application.MessageBox('Preencha todos os campos em negrito!', 'Atenção', 0);
        Exit;
      end;

    var dsTemp : TDataSet;
    dsTemp := TDaoGenerico.valida('SELECT * FROM FORNECEDOR WHERE ID = ' + edtIdFornecedor.Text);

    if not dsTemp.IsEmpty then
      begin
        if dsTemp.FieldByName('STATUS').AsString = 'N' then
          begin
            Application.MessageBox('Não é permitido fornecedores inativos!', 'Atenção', 0);
            Exit;
          end;
      end
    else
      begin
        Application.MessageBox('É necessário informar fornecedor válido!', 'Atenção', 0);
        Exit;
      end;

    inherited;
  finally
    FreeAndNil(FObjeto);
  end;
end;

procedure TfrmProduto.cdsPadraoAfterScroll(DataSet: TDataSet);
begin
  try
    TFloatField(cdsPadrao.FieldByName('PRECO_UNITARIO')).DisplayFormat := '##,##0.00';
    TFloatField(cdsPadrao.FieldByName('PRECO_UNITARIO')).EditFormat := '##,##0.00';
    FObjeto := TProduto.Create;

    Inherited;
  finally
    FreeAndNil(FObjeto);
  end;
end;

procedure TfrmProduto.edtIdFornecedorChange(Sender: TObject);
  var
    FObjetoFornecedor : TObject;
begin
  if edtIdFornecedor.Text <> '' then
    begin
      try
        FObjetoFornecedor := TFornecedor.Create;
        edtNomeFornecedorIgnore.Text := TDaoGenerico.buscaGenerica(FObjetoFornecedor, tbEqual, 'ID', edtIdFornecedor.Text).FieldByName('NOME').AsString;
      finally
        FreeAndNil(FObjetoFornecedor);
      end;
    end;
end;

procedure TfrmProduto.edtIdFornecedorDblClick(Sender: TObject);
begin
  inherited;

  with TfrmFornecedor.Create(nil) do
    try
      FTipoForm := tfBusca;
      FSomenteAtivos := True;
      ShowModal;

      edtIdFornecedor.Text := FIdSelecionado.ToString;
    finally
      Free;
    end;
end;

procedure TfrmProduto.FormCreate(Sender: TObject);
begin
  FEditChave := 'edtID';
  FEditFoco := 'edtIdFornecedor';

  inherited;
end;

end.
