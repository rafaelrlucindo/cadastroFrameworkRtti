unit untFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPadrao, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.WinXPickers, untClassFornecedor, untDaoGenerico, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils, dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar;

type
  TfrmFornecedor = class(TfrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtID: TEdit;
    edtNOME: TEdit;
    edtCNPJ: TEdit;
    edtSTATUS: TComboBox;
    procedure btnSalvarClick(Sender: TObject);
    procedure cdsPadraoAfterScroll(DataSet: TDataSet);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFornecedor: TfrmFornecedor;

implementation

uses
  System.Rtti;

{$R *.dfm}

procedure TfrmFornecedor.btnBuscarClick(Sender: TObject);
begin
  try
    FObjeto := TFornecedor.Create;
    inherited;
  finally
    FObjeto.Free;
  end;
  //inherited;
end;

procedure TfrmFornecedor.btnCancelarClick(Sender: TObject);
begin
  inherited;
  edtCNPJ.ReadOnly := False;
end;

procedure TfrmFornecedor.btnExcluirClick(Sender: TObject);
begin
  try
    FObjeto := TFornecedor.Create;
    inherited;
  finally
    FreeAndNil(FObjeto);
  end;
end;

procedure TfrmFornecedor.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtCNPJ.ReadOnly := False;
end;

procedure TfrmFornecedor.btnSalvarClick(Sender: TObject);
begin
  try
    FObjeto := TFornecedor.Create;

    if (vazio(edtNOME.Text)) or (vazio(edtNOME.Text)) or (edtSTATUS.ItemIndex < 0) then
      begin
        Application.MessageBox('Preencha todos os campos em negrito!', 'Atenção', 0);
        Exit;
      end;

    if FStatus = tsInserindo then
      if TDaoGenerico.buscaGenerica(TFornecedor.Create, tbEqual, 'CNPJ', edtCNPJ.Text).RecordCount > 0 then
        begin
          Application.MessageBox('Cnpj já cadastrado!', 'Atenção', 0);
          Exit;
        end;

    inherited;
  finally
    FreeAndNil(FObjeto);
  end;
end;

procedure TfrmFornecedor.cdsPadraoAfterScroll(DataSet: TDataSet);
begin
  try
    FObjeto := TFornecedor.Create;

    Inherited;

    if edtID.Text <> '' then
      edtCNPJ.ReadOnly := True
    else
      edtCNPJ.ReadOnly := False;
  finally
    FreeAndNil(FObjeto);
  end;
end;

procedure TfrmFornecedor.FormCreate(Sender: TObject);
begin
  if FTipoForm <> tfBusca then
    begin
      FEditChave := 'edtID';
      FEditFoco := 'edtCNPJ';
      FCampoBusca := 'nome';
    end;

  inherited;
end;

end.
