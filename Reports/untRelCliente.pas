unit untRelCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, ppProd, ppClass, ppReport, ppComm, ppRelatv, ppDB,
  ppDBPipe, untDmPrincipal, ppCtrls, ppVar, ppPrnabl, ppBands, ppCache,
  ppDesignLayer, ppParameter;

type
  TfrmRelCliente = class(TForm)
    rgStatus: TRadioGroup;
    btnSair: TBitBtn;
    BitBtn2: TBitBtn;
    ppDBRelatorio: TppDBPipeline;
    ppRelatorio: TppReport;
    qryRelatorio: TFDQuery;
    dsRelatorio: TDataSource;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLine1: TppLine;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    qryRelatorioID: TFMTBCDField;
    qryRelatorioNOME: TStringField;
    qryRelatorioSTATUS: TStringField;
    ppSummaryBand1: TppSummaryBand;
    ppLabel5: TppLabel;
    ppDBCalc1: TppDBCalc;
    ppLabel6: TppLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure ppDBText3GetText(Sender: TObject; var Text: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCliente: TfrmRelCliente;

implementation

{$R *.dfm}

procedure TfrmRelCliente.BitBtn2Click(Sender: TObject);
begin
  qryRelatorio.Close;

  case rgStatus.ItemIndex of
    0 : qryRelatorio.Params.ParamByName('STATUS').AsString := '%';
    1 : qryRelatorio.Params.ParamByName('STATUS').AsString := 'S';
    2 : qryRelatorio.Params.ParamByName('STATUS').AsString := 'N';
  end;

  qryRelatorio.Open;

  if not qryRelatorio.IsEmpty then
    ppRelatorio.Print
  else
    Application.MessageBox('Nenhum resultado encontrado!', 'Aten??o', 0);
end;

procedure TfrmRelCliente.btnSairClick(Sender: TObject);
begin
  qryRelatorio.Close;
  Close;
end;

procedure TfrmRelCliente.ppDBText3GetText(Sender: TObject; var Text: string);
begin
  if Text = 'S' then
    Text := 'SIM'
  else
    Text := 'N?O';
end;

end.
