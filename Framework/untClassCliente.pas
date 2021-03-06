unit untClassCliente;

interface

uses
  untEntidadeGenerica, untEntidadeAtributos, System.Classes;

type
  [Tablename('CLIENTE')]
  [OrderBy('NOME')]
  [SomenteAtivos(' STATUS = ''S''')]

  TCliente = class(TEntidadeGenerica)

    private
      FId : integer;
      FNome : string;
      FCpf : string;
      FStatus : string;
      FData_Nascimento : String;

      procedure setId(aValue:Integer);
      procedure setNome(aValue:String);
      procedure setCpf(aValue:String);
      procedure setStatus(aValue:String);
      procedure setData_Nascimento(aValue:String);

    public
      constructor Create;

      [KeyField('ID')]
      [FieldName('ID')]
      property id : Integer read FId write setId;

      [FieldName('NOME')]
      [FieldFind('NOME')]
      property nome : String read FNome write setNome;

      [FieldName('CPF')]
      [FieldFind('CPF')]
      property cpf : String read FCpf write setCpf;

      [FieldName('STATUS')]
      [FieldFind('STATUS')]
      property status : String read FStatus write setStatus;

      [FieldName('DATA_NASCIMENTO')]
      property data_nascimento : String read FData_Nascimento write setData_Nascimento;
  end;

implementation

{ TCliente }

constructor TCliente.Create;
begin
  inherited Create;
end;

procedure TCliente.setCpf(aValue: String);
begin
  FCpf := aValue;
end;

procedure TCliente.setData_Nascimento(aValue: String);
begin
  FData_Nascimento := aValue;
end;

procedure TCliente.setId(aValue: Integer);
begin
  FId := aValue;
end;

procedure TCliente.setNome(aValue: String);
begin
  FNome := aValue;
end;

procedure TCliente.setStatus(aValue: String);
begin
  FStatus := aValue;
end;

end.
