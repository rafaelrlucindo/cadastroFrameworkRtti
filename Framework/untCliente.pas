unit untCliente;

interface

uses
  untEntidade, untEntidadeAtributos;

type
  [Tablename('CLIENTE')]

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
      procedure setData_Nascimento(aValue:TDate);

    public
      [KeyField('ID')]
      [FieldName('ID')]
      property id : Integer read FId write setId;

      [FieldName('NOME')]
      property nome : String read FNome write setNome;

      [FieldName('CPF')]
      property telefone : String read FCpf write setCpf;

      [FieldName('STATUS')]
      property email : String read FStatus write setStatus;

      [FieldName('DATA_NASCIMENTO')]
      property endereco : String read FData_Nascimento write setData_Nascimento;
  end;

implementation

{ TCliente }

procedure TCliente.setCpf(aValue: String);
begin
  FCpf := aValue;
end;

procedure TCliente.setData_Nascimento(aValue: TDate);
begin
  FData_Nascimento := aValue;
end;

procedure TCliente.setId(aValue: Integer);
begin
  FId := setId;
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
