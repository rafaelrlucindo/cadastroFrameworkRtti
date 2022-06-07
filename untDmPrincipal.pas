unit untDmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Phys.OracleDef, FireDAC.Phys.Oracle;

type
  TdmPrincipal = class(TDataModule)
    connPrincipal: TFDConnection;
    qryServidor: TFDQuery;
    qryGeraCodigo: TFDQuery;
    FDPhysOracleDriverLink1: TFDPhysOracleDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
    function conectar:Boolean;
    function desconectar:Boolean;

    function getDataSet(aSQL:string):TFDQuery;
    function execSQL(aSQL:string):Boolean;
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmPrincipal }

function TdmPrincipal.conectar: Boolean;
begin
  try
    connPrincipal.Connected := True;
    Result := True;
  except
    Result := False;
  end;
end;

function TdmPrincipal.desconectar: Boolean;
begin
  try
    connPrincipal.Connected := False;
    Result := True;
  except
    Result := False;
  end;
end;

function TdmPrincipal.execSQL(aSQL: string): Boolean;
begin
  qryServidor.Close;
  qryServidor.SQL.Text := aSQL;

  try
    qryServidor.ExecSQL;
    Result := True;
  except
    on e : Exception do
      begin
        raise Exception.Create(e.Message);
      end;
  end;
end;

function TdmPrincipal.getDataSet(aSQL: string): TFDQuery;
begin
  qryServidor.Close;
  qryServidor.SQL.Text := aSQL;

  try
    qryServidor.Open;
    Result := qryServidor;
  except
    on e : Exception do
      begin
        raise Exception.Create(e.Message);
      end;
  end;
end;

end.
