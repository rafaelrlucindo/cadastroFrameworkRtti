unit untPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Datasnap.Provider, Datasnap.DBClient,
  Vcl.Grids, Vcl.DBGrids, untDaoGenerico, Vcl.Mask, Vcl.DBCtrls,
  rtti, untEntidadeAtributos, TypInfo, System.Generics.Collections,
  untClassCliente, Vcl.WinXPickers, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxCurrencyEdit, untDmPrincipal, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TStatus = (tsInserindo, tsAlterando);
  TTipoForm = (tfManutencao, tfBusca);

  TfrmPadrao = class(TForm)
    ToolBar1: TToolBar;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnSair: TBitBtn;
    btnPesquisar: TBitBtn;
    pnlPrincipal: TPanel;
    pnlDados: TPanel;
    pnlGrid: TPanel;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    btn1: TToolButton;
    ToolButton3: TToolButton;
    GroupBox1: TGroupBox;
    btnBuscar: TSpeedButton;
    edtBusca: TEdit;
    dbgPadrao: TDBGrid;
    shpGridZebra: TShape;
    shpGridSel: TShape;
    btnSeleciona: TBitBtn;
    dsPadrao: TDataSource;
    dspPadrao: TDataSetProvider;
    cdsPadrao: TClientDataSet;
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtBuscaExit(Sender: TObject);
    procedure edtBuscaEnter(Sender: TObject);
    procedure dbePadraoEnter(Sender: TObject);
    procedure dbePadraoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtBuscaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure cdsPadraoAfterScroll(DataSet: TDataSet);
    procedure dbgPadraoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSelecionaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure limpaObjetos;
    procedure ocultarBotoes;
    procedure afterScroll(DataSet: TDataSet);
  end;

var
  frmPadrao: TfrmPadrao;
  FObjeto : TObject;
  FEditChave : string;
  FEditFoco : string;
  FCampoBusca : String;
  FAtivo : string;
  FTipoForm : TTipoForm;
  FIdSelecionado : Integer;
  FStatus : TStatus;
  FSomenteAtivos : Boolean;

implementation

{$R *.dfm}

//procedure limpaObjetos;

procedure TfrmPadrao.afterScroll(DataSet: TDataSet);
  var
    Contexto: TRttiContext;
    Tipo: TRttiType;
    Propriedade: TRttiProperty;
    Valor: variant;
    aComponente: TComponent;
begin
  FStatus := tsAlterando;

  if FObjeto = nil then
    Exit;

  Contexto := TRttiContext.Create;
  Tipo := Contexto.GetType(FObjeto.ClassInfo);
  try
    for Propriedade in Tipo.GetProperties do
      begin
        aComponente :=  Self.FindComponent('edt' + Propriedade.Name);
        if Pos('IGNORE', aComponente.name) > 0 then
          Continue;
        if aComponente is TEdit then
           TEdit(aComponente).Text := DataSet.FieldByName(Propriedade.Name).AsString;
        if aComponente is TComboBox then
          begin
            if DataSet.FieldByName(Propriedade.Name).AsString = 'S' then
              TComboBox(aComponente).ItemIndex := 0
            else if Valor = 'N' then
              TComboBox(aComponente).ItemIndex := 1;
          end;
        if aComponente is TcxDateEdit then
          TcxDateEdit(aComponente).Text := DataSet.FieldByName(Propriedade.Name).AsString;
        if aComponente is TcxCurrencyEdit then
          TcxCurrencyEdit(aComponente).Value := DataSet.FieldByName(Propriedade.Name).AsFloat;
      end;
  finally
    Contexto.Free;
  end;
end;

procedure TfrmPadrao.btnBuscarClick(Sender: TObject);
begin
  try
    if FObjeto = nil then
      Exit;

    cdsPadrao.Close;
    dspPadrao.DataSet := TDaoGenerico.buscaGenerica(FObjeto, tbLike, iif(FCampoBusca <> '', FCampoBusca, 'NOME'), edtBusca.Text, FSomenteAtivos);
    cdsPadrao.Open;
  finally
  end;
end;

procedure TfrmPadrao.btnCancelarClick(Sender: TObject);
begin
  limpaObjetos;
  cdsPadrao.EmptyDataSet;
end;

procedure TfrmPadrao.btnExcluirClick(Sender: TObject);
begin
  if TEdit(FindComponent(FEditChave)).Text = '' then
    Exit;

  if FObjeto = nil then
    Exit;

  try
    TDaoGenerico.deleta(FObjeto, StrToIntDef(TEdit(FindComponent(FEditChave)).Text, 0));
    cdsPadrao.Delete;
    Application.MessageBox('Registro deletado com sucesso!', 'Atenção',  0);
    limpaObjetos;
  finally
    FObjeto.Free;
  end;
end;

procedure TfrmPadrao.btnNovoClick(Sender: TObject);
begin
  FStatus := tsInserindo;

  limpaObjetos;

  if cdsPadrao.Active then
    cdsPadrao.EmptyDataSet;

  TEdit(FindComponent(FEditFoco)).SetFocus;
end;

procedure TfrmPadrao.btnPesquisarClick(Sender: TObject);
begin
  FStatus := tsInserindo;
  limpaObjetos;
  edtBusca.SetFocus;
end;

procedure TfrmPadrao.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPadrao.btnSalvarClick(Sender: TObject);
  var
    contexto : TRttiContext;
    typObjeto : TRttiType;
    prop : TRttiProperty;
    aComponente: TComponent;
    intId:Integer;
begin
  intId := 0;

  if FObjeto = nil then
    Exit;

  contexto := TRttiContext.Create;
  typObjeto := Contexto.GetType(FObjeto.ClassInfo);
    for prop in typObjeto.GetProperties do
      begin
        aComponente :=  Self.FindComponent('edt' + prop.Name);

        if aComponente.Name = FEditChave then
          intId := StrToIntDef(TEdit(aComponente).Text, 0);

        if aComponente <> nil then
          begin
            case prop.GetValue(FObjeto).TypeInfo.Kind of
               tkWChar,
               tkLString,
               tkWString,
               tkString,
                tkChar,
               tkUString: begin
                 if aComponente is TComboBox then
                   prop.SetValue(Pointer(FObjeto), copy(TEdit(aComponente).Text, 1, 1))
                 else
                   prop.SetValue(Pointer(FObjeto), TEdit(aComponente).Text);
               end;

              tkInteger : prop.SetValue(Pointer(FObjeto), strToIntDef(TEdit(aComponente).Text, 0));
                 tkFloat: prop.SetValue(Pointer(FObjeto), TcxCurrencyEdit(aComponente).Value);
            end;
          end;
      end;

  if intId = 0 then
    try
      TEdit(FindComponent(FEditChave)).Text := TDaoGenerico.insere(FObjeto).ToString;
      Application.MessageBox('Registro inserido com sucesso!', 'Atenção', 0);
    except
    end
  else
    try
      TDaoGenerico.update(FObjeto);
      Application.MessageBox('Registro alterado com sucesso!', 'Atenção', 0);
    except
    end;

  // retorno
  cdsPadrao.Close;
  dspPadrao.DataSet := TDaoGenerico.buscaGenerica(FObjeto, tbEqual, 'ID', TEdit(FindComponent(FEditChave)).Text);
  cdsPadrao.Open;
end;

procedure TfrmPadrao.btnSelecionaClick(Sender: TObject);
begin
  FIdSelecionado := 0;

  if not cdsPadrao.Active then
    Exit;

  if cdsPadrao.RecordCount > 0  then
    begin
      FIdSelecionado := StrToIntDef(cdsPadrao.FieldByName('ID').AsString, 0);
      Close;
    end;
end;

procedure TfrmPadrao.cdsPadraoAfterScroll(DataSet: TDataSet);
  var
    Contexto: TRttiContext;
    Tipo: TRttiType;
    Propriedade: TRttiProperty;
    Valor: variant;
    aComponente: TComponent;
begin
  FStatus := tsAlterando;

  if FObjeto = nil then
    Exit;

  Contexto := TRttiContext.Create;
  Tipo := Contexto.GetType(FObjeto.ClassInfo);
  try
    for Propriedade in Tipo.GetProperties do
      begin
        aComponente :=  Self.FindComponent('edt' + Propriedade.Name);
        if Pos('IGNORE', aComponente.name) > 0 then
          Continue;
        if aComponente is TEdit then
           TEdit(aComponente).Text := cdsPadrao.FieldByName(Propriedade.Name).AsString;
        if aComponente is TComboBox then
          begin
            if cdsPadrao.FieldByName(Propriedade.Name).AsString = 'S' then
              TComboBox(aComponente).ItemIndex := 0
            else
              TComboBox(aComponente).ItemIndex := 1;
          end;
        if aComponente is TcxDateEdit then
          TcxDateEdit(aComponente).Text := cdsPadrao.FieldByName(Propriedade.Name).AsString;
        if aComponente is TcxCurrencyEdit then
          TcxCurrencyEdit(aComponente).Value := cdsPadrao.FieldByName(Propriedade.Name).AsFloat;
      end;
  finally
    Contexto.Free;
  end;
end;

procedure TfrmPadrao.dbePadraoEnter(Sender: TObject);
begin
  TCustomEdit(TObject(Sender)).Brush.Color := clYellow;
end;

procedure TfrmPadrao.dbePadraoExit(Sender: TObject);
begin
  TCustomEdit(TObject(Sender)).Brush.Color := clWhite;
end;

procedure TfrmPadrao.dbgPadraoDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gdSelected in State then
    begin
      dbgPadrao.Canvas.Brush.Color := shpGridSel.Brush.Color;
      dbgPadrao.Canvas.Font.Color := clWhite;
      dbgPadrao.Canvas.Font.Style := [fsBold];
    end
  else
    begin
      if Odd(cdsPadrao.RecNo) then
        begin
          dbgPadrao.Canvas.Brush.Color := shpGridZebra.Brush.Color;
          dbgPadrao.Canvas.Font.Color := clBlack;
          dbgPadrao.Canvas.Font.Style := [];
        end
      else
        begin
          dbgPadrao.Canvas.Brush.Color := clWhite;
          dbgPadrao.Canvas.Font.Color := clBlack;
          dbgPadrao.Canvas.Font.Style := [];
        end;
    end;

  dbgPadrao.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmPadrao.edtBuscaEnter(Sender: TObject);
begin
  TCustomEdit(TObject(Sender)).Brush.Color := clYellow;
  TCustomEdit(TObject(Sender)).SelectAll;
end;

procedure TfrmPadrao.edtBuscaExit(Sender: TObject);
begin
  TCustomEdit(TObject(Sender)).Brush.Color := clWhite;
end;

procedure TfrmPadrao.edtBuscaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    if edtBusca.Text <> '' then
      begin
        btnBuscar.Click;
        edtBusca.SetFocus;
      end;
end;

procedure TfrmPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmPadrao.FormCreate(Sender: TObject);
begin
  frmPadrao := nil;
end;

procedure TfrmPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if FTipoForm = tfBusca then
    begin
      if Shift = [] then
        case key of
          VK_RETURN : Perform(WM_NEXTDLGCTL, 0, 0);
          VK_F6 : btnSeleciona.Click;
          VK_ESCAPE : btnSair.Click;
        end;
    end
  else
    begin
      if Shift = [] then
        case key of
          VK_RETURN : Perform(WM_NEXTDLGCTL, 0, 0);
          VK_F2 : btnNovo.Click;
          VK_F3 : btnSalvar.Click;
          VK_F4 : btnCancelar.Click;
          VK_F5 : btnExcluir.Click;
          VK_F6 : btnSeleciona.Click;
          VK_F7 : btnPesquisar.Click;
          VK_ESCAPE : btnSair.Click;
        end;
    end;
end;

procedure TfrmPadrao.FormShow(Sender: TObject);
begin
  limpaObjetos;

  if FTipoForm = tfBusca then
    begin
      ocultarBotoes;
      Self.Width := 220;
      edtBusca.SetFocus;
    end
  else
    btnSeleciona.Visible := False;
end;

procedure TfrmPadrao.limpaObjetos;
begin
  if cdsPadrao.Active then
    cdsPadrao.EmptyDataSet;

  for var i := 0 to ComponentCount -1 do
    begin
      if Components[i] is TEdit then
        TEdit(Components[i]).Clear;

      if Components[i] is TComboBox then
        TComboBox(Components[i]).ItemIndex := -1;

      if Components[i] is TcxDateEdit then
        TcxDateEdit(Components[i]).Clear;

      if Components[i] is TcxCurrencyEdit then
        TcxCurrencyEdit(Components[i]).Clear;
    end;

  //TEdit(FindComponent(FEditFoco)).SetFocus;
end;

procedure TfrmPadrao.ocultarBotoes;
begin
  for var i := 0 to ComponentCount -1 do
    begin
      if Components[i] is TToolButton then
        if TToolButton(Components[i]).Tag = 999 then
          TToolButton(Components[i]).Visible := False;

      if Components[i] is TBitBtn then
        if TBitBtn(Components[i]).Tag = 999 then
            TToolButton(Components[i]).Visible := False;
    end;
end;

end.
