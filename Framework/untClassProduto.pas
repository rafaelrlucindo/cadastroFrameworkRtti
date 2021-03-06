unit untClassProduto;

interface

uses
  untEntidadeGenerica, untEntidadeAtributos, System.Classes;

type
  [Tablename('PRODUTO')]
  [CamposSQL('ID, IDFORNECEDOR, DESCRICAO, STATUS, CAST(PRECO_UNITARIO AS FLOAT) PRECO_UNITARIO')]
  [OrderBy('DESCRICAO')]
  [SomenteAtivos(' STATUS = ''S''')]

  TProduto = class(TEntidadeGenerica)

    private
      FId : integer;
      FDescricao : string;
      FPreco_Unitario : Double;
      FStatus : string;
      FIdFornecedor: integer;
      //FNomeFornecedor: string;

      procedure setId(aValue:Integer);
      procedure setDescricao(aValue:String);
      procedure setPreco_Unitario(aValue:Double);
      procedure setStatus(aValue:String);
      procedure setIdFornecedor(const Value: integer);
      //procedure setNomeFornecedor(const Value: string);

    public
      constructor Create;



      [KeyField('ID')]
      [FieldName('ID')]
      [FieldFind('ID')]
      property id : Integer read FId write setId;

      [FieldName('IDFORNECEDOR')]
      [FieldFind('IDFORNECEDOR')]
      property idFornecedor : integer read FIdFornecedor write setIdFornecedor;

      [FieldName('DESCRICAO')]
      [FieldFind('DESCRICAO')]
      property descricao : String read FDescricao write setDescricao;

      [FieldName('PRECO_UNITARIO')]
      property preco_unitario : Double read FPreco_Unitario write FPreco_Unitario;

      [FieldName('STATUS')]
      property status : String read FStatus write setStatus;
  end;

implementation

{ TCliente }

constructor TProduto.Create;
begin
  inherited Create;
end;

procedure TProduto.setPreco_Unitario(aValue: Double);
begin
  FPreco_Unitario := aValue;
end;

procedure TProduto.setId(aValue: Integer);
begin
  FId := aValue;
end;

procedure TProduto.setIdFornecedor(const Value: integer);
begin
  FIdFornecedor := Value;
end;

//procedure TProduto.setNomeFornecedor(const Value: string);
//begin
//  FNomeFornecedor := Value;
//end;

procedure TProduto.setDescricao(aValue: String);
begin
  FDescricao := aValue;
end;

procedure TProduto.setStatus(aValue: String);
begin
  FStatus := aValue;
end;

end.
