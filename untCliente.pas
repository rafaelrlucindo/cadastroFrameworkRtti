unit untCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPadrao, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.WinXPickers, untClassCliente, untDaoGenerico, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils, dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar;

type
  TfrmCliente = class(TfrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtID: TEdit;
    edtNOME: TEdit;
    edtCPF: TEdit;
    edtSTATUS: TComboBox;
    edtData_Nascimento: TcxDateEdit;
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
  frmCliente: TfrmCliente;

implementation

uses
  System.Rtti;

{$R *.dfm}

procedure TfrmCliente.btnBuscarClick(Sender: TObject);
begin
  try
    FObjeto := TCliente.Create;
    inherited;
  finally
    FObjeto.Free;
  end;
  inherited;
end;

procedure TfrmCliente.btnCancelarClick(Sender: TObject);
begin
  inherited;
  edtCPF.ReadOnly := False;
end;

procedure TfrmCliente.btnExcluirClick(Sender: TObject);
begin
  try
    FObjeto := TCliente.Create;
    inherited;
  finally
    FreeAndNil(FObjeto);
  end;
end;

procedure TfrmCliente.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtCPF.ReadOnly := False;
end;

procedure TfrmCliente.btnSalvarClick(Sender: TObject);
begin
  try
    FObjeto := TCliente.Create;

    if (vazio(edtCPF.Text)) or (vazio(edtNOME.Text))
      or (edtSTATUS.ItemIndex < 0) or (vazio(edtData_Nascimento.Text)) then
      begin
        Application.MessageBox('Preencha todos os campos em negrito!', 'Atenção', 0);
        Exit;
      end;

    if FStatus = tsInserindo then
      if TDaoGenerico.buscaGenerica(TCliente.Create, tbEqual, 'CPF', edtCPF.Text).RecordCount > 0 then
        begin
          Application.MessageBox('Cpf já cadastrado!', 'Atenção', 0);
          Exit;
        end;

    inherited;
  finally
    FreeAndNil(FObjeto);
  end;
end;

procedure TfrmCliente.cdsPadraoAfterScroll(DataSet: TDataSet);
begin
  try
    FObjeto := TCliente.Create;

    Inherited;

    if edtID.Text <> '' then
      edtCPF.ReadOnly := True
    else
      edtCPF.ReadOnly := False;
  finally
    FreeAndNil(FObjeto);
  end;
end;

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
  inherited;
  FEditChave := 'edtID';
  FEditFoco := 'edtCpf';
  FCampoBusca := 'nome';
end;

end.
