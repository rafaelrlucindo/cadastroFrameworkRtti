unit untClassFornecedor;

interface

uses
  untEntidadeGenerica, untEntidadeAtributos, System.Classes;

type
  [Tablename('FORNECEDOR')]
  [OrderBy('NOME')]
  [SomenteAtivos(' STATUS = ''S''')]

  TFornecedor = class(TEntidadeGenerica)

    private
      FId : integer;
      FNome : string;
      FCnpj : string;
      FStatus : string;

      procedure setId(aValue:Integer);
      procedure setNome(aValue:String);
      procedure setCnpj(aValue:String);
      procedure setStatus(aValue:String);

    public
      constructor Create(aNomeBusca:String=''; aCnpjBusca:String='');

      [KeyField('ID')]
      [FieldName('ID')]
      [FieldFind('ID')]
      property id : Integer read FId write setId;

      [FieldName('NOME')]
      [FieldFind('NOME')]
      property nome : String read FNome write setNome;

      [FieldName('CNPJ')]
      property cnpj : String read FCnpj write setCnpj;

      [FieldName('STATUS')]
      [FieldFind('STATUS')]
      property status : String read FStatus write setStatus;
  end;

implementation

{ TCliente }

constructor TFornecedor.Create(aNomeBusca, aCnpjBusca: String);
begin
  inherited Create;

  if aNomeBusca <> '' then
    FNome := aNomeBusca;

  if aCnpjBusca <> '' then
    FCnpj := aCnpjBusca;
end;

procedure TFornecedor.setCnpj(aValue: String);
begin
  FCnpj := aValue;
end;

procedure TFornecedor.setId(aValue: Integer);
begin
  FId := aValue;
end;

procedure TFornecedor.setNome(aValue: String);
begin
  FNome := aValue;
end;

procedure TFornecedor.setStatus(aValue: String);
begin
  FStatus := aValue;
end;

end.
