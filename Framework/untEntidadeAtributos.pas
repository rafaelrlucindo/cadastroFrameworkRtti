unit untEntidadeAtributos;

interface

type
  TableName = class(TCustomAttribute)

    private
      FName : string;

    public
      constructor Create(aName: string);
      property name : string read FName write FName;
  end;

  CamposSQL = class(TCustomAttribute)

    private
      FName : string;

    public
      constructor Create(aName: string);
      property name : string read FName write FName;
  end;

  OrderBy = class(TCustomAttribute)

    private
      FName : string;

    public
      constructor Create(aName: string);
      property name : string read FName write FName;
  end;

  SomenteAtivos = class(TCustomAttribute)

    private
      FName : string;

    public
      constructor Create(aName: string);
      property name : string read FName write FName;
  end;

  type
    KeyField = class(TCustomAttribute)

    private
      FName : string;

    public
      constructor Create(aName: string);
      property name : string read FName write FName;
  end;

  type
    FieldName = class(TCustomAttribute)

    private
      FName : string;

    public
      constructor Create(aName: string);
      property name : string read FName write FName;
  end;

  type
    FieldFind = class(TCustomAttribute)

    private
      FName : string;

    public
      constructor Create(aName: string);
      property name : string read FName write FName;
  end;


implementation

  { KeyField }

constructor KeyField.Create(aName: string);
begin
  FName := aName;
end;


{ TableName }

constructor TableName.Create(aName: string);
begin
  FName := aName;
end;

{ FieldName }

constructor FieldName.Create(aName: string);
begin
  FName := aName;
end;

{ FieldFind }

constructor FieldFind.Create(aName: string);
begin
  FName := aName;
end;

{ CamposSQL }

constructor CamposSQL.Create(aName: string);
begin
  FName := aName;
end;

{ OrderBy }

constructor OrderBy.Create(aName: string);
begin
  FName := aName;
end;

{ SomenteAtivos }

constructor SomenteAtivos.Create(aName: string);
begin
  FName := aName;
end;

end.
