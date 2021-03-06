unit untDaoGenerico;

interface

uses
  db, rtti, untEntidadeAtributos, TypInfo, System.SysUtils,
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Generics.Collections, Vcl.StdCtrls, Vcl.ExtCtrls,
  Winapi.Windows, Winapi.Messages, System.Variants,
  Vcl.ComCtrls,  untDmPrincipal, StrUtils, Datasnap.Provider;



type
  TTipoBusca = (tbEqual, tbLike);

  TCampo = record
    FCampo : string;
    FValor : Variant;
    FTipo : TTipoBusca;
  end;

  TDaoGenerico = class
    private
      class function getTableName<T: class>(Objeto: T):string;
      class function getCamposSQL<T: class>(Objeto: T):string;
      class function getOrderBy<T: class>(Objeto: T):string;
      class function getSomenteAtivos<T: class>(Objeto: T):string;

      //class function carregar<aCampo>: TDataSet; static;

    public
      class function insere<T: class>(Objeto: T):integer;
      class function update<T: class>(Objeto: T):Boolean;
      class function valida(aSQL:String): TDataSet;
      class function buscaGenerica<T: class>(Objeto: T; aTipoBusca:TTipoBusca=tbEqual; aCampo:String=''; aValor:String=''; aSomenteAtivos:Boolean=False):TDataSet;
      class function deleta<T: class>(Objeto: T; aId:Integer):Boolean;
  end;

  function iif(Test: boolean; TrueR, FalseR: string): string; overload;
  function iif(Test: boolean; TrueR, FalseR: Variant): Variant; overload;
  function iif(Test: boolean; aTrue, aFalse: Boolean): Boolean; overload;
  function vazio(const value:string):Boolean; overload;
  function vazio(const value:TDateTime):Boolean; overload;
  function vazio(const value:TField):Boolean; overload;

implementation

uses
  FMX.Types, Datasnap.DBClient;

{ TDaoGenerico }

function iif(Test: boolean; TrueR, FalseR: string): string;
begin
  if Test then
    Result := TrueR
  else
    Result := FalseR;
end;

function iif(Test: boolean; TrueR, FalseR: Variant): Variant;
begin
  if Test then
    Result := TrueR
  else
    Result := FalseR;
end;

function iif(Test: boolean; aTrue, aFalse: Boolean): Boolean;
begin
  if Test then
    Result := aTrue
  else
    Result := aFalse;
end;

function vazio(const value:string):Boolean;
begin
  Result := (value = EmptyStr) or (value = null) or (trim(value) = '');
end;

function vazio(const value:TDateTime):Boolean;
begin
  Result := (value = 0);
end;

function vazio(const value:TField):Boolean; overload;
begin
  Result := ((value.IsNull) or (Trim(value.AsString) = ''));
end;

class function TDaoGenerico.buscaGenerica<T>(Objeto: T; aTipoBusca: TTipoBusca; aCampo:String; aValor:String; aSomenteAtivos:Boolean): TDataSet;
  var
    Contexto: TRttiContext;
    TypObj: TRttiType;
    TypObjBusca: TRttiType;
    Prop: TRttiProperty;
    PropBusca : TRttiProperty;
    Atributo: TCustomAttribute;
    strSQL : string;
    strClausula : string;
    strBusca : string;
    //strCamposSQL : String;
begin
  if not vazio(aCampo) then
    begin
      case aTipoBusca of
        tbEqual : strClausula := ' WHERE ' + aCampo + ' = ''' + aValor + '''';
        tbLike: strClausula := ' WHERE ' + aCampo + ' LIKE ''%' + aValor + '%''';
      end;
    end
  else
    begin
      Contexto  := TRttiContext.Create;
      TypObj := Contexto.GetType(TObject(Objeto).ClassType);
      TypObjBusca := Contexto.GetType(TObject(Objeto).ClassInfo);

      for Prop in TypObj.GetProperties do
        begin
          for Atributo in Prop.GetAttributes do
            begin
              if (Atributo is FieldFind) then
                begin
                  TypObjBusca:= contexto.GetType(TObject(Objeto).ClassInfo);
                  PropBusca:= TypObj.GetProperty(FieldFind(Atributo).name); //'NOME'
                  strBusca := Prop.GetValue(TObject(Objeto)).ToString;

                  if (strBusca <> '') or ((aCampo <> '') and (aValor <> '' )) then
                    begin
                      if strClausula = '' then
                        begin
                          case aTipoBusca of
                            tbEqual : strClausula := ' WHERE ' + FieldFind(Atributo).name + ' = ''' + strBusca + '''';
                            tbLike: strClausula := ' WHERE ' + FieldFind(Atributo).name + '''%' + strBusca + '%''';
                          end;
                        end
                      else
                        begin
                          case aTipoBusca of
                            tbEqual : strClausula := strClausula + ' AND ' + FieldFind(Atributo).name + ' = ''' + strBusca + '''';
                            tbLike: strClausula := strClausula + ' AND ' + FieldFind(Atributo).name + '''%' + strBusca + '%''';
                          end;
                        end;
                    end;

                  log.d('Busca..: ' + FieldFind(Atributo).name + ' = ' + strBusca);
                end;
            end;
        end;
    end;

  if aSomenteAtivos then
    if not vazio(getSomenteAtivos(TObject(Objeto))) then
      strClausula := strClausula + iif(vazio(strClausula), ' WHERE ' + getSomenteAtivos(TObject(Objeto)), ' AND ' + getSomenteAtivos(TObject(Objeto)));

  strSQL := 'SELECT ' +
    iif(not vazio(getCamposSQL(TObject(Objeto))), getCamposSQL(TObject(Objeto)), ' * ') +
      ' FROM ' + getTableName(TObject(Objeto)) + strClausula +
        iif(not vazio(getOrderBy(TObject(Objeto))), ' ORDER BY ' + getOrderBy(TObject(Objeto)), ' ');

  if not vazio(strSQL) then
    Result := dmPrincipal.getDataSet(strSQL)
  else
    Result := nil;
end;

class function TDaoGenerico.deleta<T>(Objeto: T; aId:Integer): Boolean;
  var
    Contexto: TRttiContext;
    TypObj: TRttiType;
    TypObjBusca: TRttiType;
    Prop: TRttiProperty;
    PropBusca : TRttiProperty;
    Atributo: TCustomAttribute;
    strClausula : string;
begin
  Result := False;

  Contexto  := TRttiContext.Create;
  TypObj := Contexto.GetType(TObject(Objeto).ClassType);
  TypObjBusca := Contexto.GetType(TObject(Objeto).ClassInfo);

  for Prop in TypObj.GetProperties do
    begin
      for Atributo in Prop.GetAttributes do
        begin
          Length(Prop.GetAttributes);

          if (Atributo is KeyField) then
            begin
              TypObjBusca:= contexto.GetType(TObject(Objeto).ClassInfo);
              PropBusca:= TypObj.GetProperty(FieldFind(Atributo).name);
              strClausula := ' WHERE ' + FieldFind(Atributo).name + ' = ' + aId.ToString;
            end;
        end;
    end;

  try
    dmPrincipal. execSQL('DELETE FROM ' + getTableName(Objeto) + strClausula );
    Result := True;
  except
    // silenciosa
  end;
end;

class function TDaoGenerico.getCamposSQL<T>(Objeto: T): string;
  var
    contexto : TRttiContext;
    typObjeto : TRttiType;
    Atributo : TCustomAttribute;
begin
  contexto := TRttiContext.Create;
  typObjeto := contexto.GetType(TObject(Objeto).ClassInfo);

  for Atributo in typObjeto.GetAttributes do
    if Atributo is camposSQL then
      Exit(CamposSQL(Atributo).name);
end;

class function TDaoGenerico.getOrderBy<T>(Objeto: T): string;
  var
    contexto : TRttiContext;
    typObjeto : TRttiType;
    Atributo : TCustomAttribute;
begin
  contexto := TRttiContext.Create;
  typObjeto := contexto.GetType(TObject(Objeto).ClassInfo);

  for Atributo in typObjeto.GetAttributes do
    if Atributo is OrderBy then
      Exit(OrderBy(Atributo).name);
end;

class function TDaoGenerico.getSomenteAtivos<T>(Objeto: T): string;
  var
    contexto : TRttiContext;
    typObjeto : TRttiType;
    Atributo : TCustomAttribute;
begin
  contexto := TRttiContext.Create;
  typObjeto := contexto.GetType(TObject(Objeto).ClassInfo);

  for Atributo in typObjeto.GetAttributes do
    if Atributo is SomenteAtivos then
      Exit(SomenteAtivos(Atributo).name);
end;

class function TDaoGenerico.getTableName<T>(Objeto: T): string;
  var
    contexto : TRttiContext;
    typObjeto : TRttiType;
    Atributo : TCustomAttribute;
begin
  contexto := TRttiContext.Create;
  typObjeto := contexto.GetType(TObject(Objeto).ClassInfo);

  for Atributo in typObjeto.GetAttributes do
    if Atributo is TableName then
      Exit(TableName(Atributo).name);
end;

class function TDaoGenerico.insere<T>(Objeto: T): integer;
  var
    contexto : TRttiContext;
    typObjeto : TRttiType;
    prop : TRttiProperty;
    strSQL : string;
    strCampos : String;
    strValores : String;
    atributo : TCustomAttribute;
    campo : string;
    chave : string;
begin
  contexto := TRttiContext.Create;
  typObjeto :=  contexto.GetType(TObject(Objeto).ClassInfo);

  for prop in typObjeto.GetProperties do
    begin
      for atributo in prop.GetAttributes do
        begin
          if atributo is KeyField then
            begin
              campo := KeyField(atributo).name;
              chave := KeyField(atributo).name;

              dmPrincipal.qryGeraCodigo.Close;
              dmPrincipal.qryGeraCodigo.SQL.Text := 'SELECT COALESCE(MAX(' + KeyField(atributo).name + ')+1, 1) AS CODIGO FROM ' + GetTableName(Objeto);
              dmPrincipal.qryGeraCodigo.open;

              strCampos := campo + ',';
              strValores := IntToStr(dmPrincipal.qryGeraCodigo.FieldByName('CODIGO').AsInteger) + ',';
            end;

          if (atributo is FieldName) and (chave <> FieldName(atributo).name) then
            begin
              if Pos('IGNORE', FieldName(atributo).name) > 0 then
                Continue;

              strCampos := strCampos + FieldName(atributo).name + ',';

              case prop.GetValue(TObject(Objeto)).TypeInfo.Kind of
                tkWChar, tkLString, tkWString, tkString,
                tkChar, tkUString: begin
                  strValores := strValores + #39 + prop.GetValue(TObject(Objeto)).AsString + #39 + ',';
                end;

                tkInteger: begin
                  strValores := strValores +IntToStr(prop.GetValue(TObject(Objeto)).AsInteger) + ',';
                end;

                tkFloat: strValores := strValores +
                  StringReplace(FloatToStr(prop.GetValue(TObject(Objeto)).AsExtended), ',', '.', [rfReplaceAll]) + ',';
              else
                raise Exception.Create('Formato n?o suportado!');
              end;
            end;
        end;
    end;

  strCampos := Copy(strCampos, 1, Length(strCampos) - 1);
  strValores := Copy(strValores, 1, Length(strValores) - 1);
  strSQL := 'INSERT INTO ' + GetTableName(Objeto) + '(' + strCampos + ')VALUES(' + strValores + ')';

  try
    dmPrincipal. execSQL(strSQL);
    Result := dmPrincipal.qryGeraCodigo.FieldByName('CODIGO').AsInteger;
  except
    Result := -1;
  end;
end;

class function TDaoGenerico.update<T>(Objeto: T): Boolean;
  var
    contexto : TRttiContext;
    typObjeto : TRttiType;
    prop : TRttiProperty;
    TypObjBusca: TRttiType;
    PropBusca : TRttiProperty;
    strSQL : string;
    strClausula : string;
    strCampos : String;
    atributo : TCustomAttribute;
    strBusca : String;
begin
  Result := False;

  strSQL := 'UPDATE ' + getTableName(Objeto) +  ' SET ';

  contexto := TRttiContext.Create;
  typObjeto :=  contexto.GetType(TObject(Objeto).ClassInfo);

  for prop in typObjeto.GetProperties do
    begin
      for atributo in prop.GetAttributes do
        begin
          TypObjBusca:= contexto.GetType(TObject(Objeto).ClassInfo);
          PropBusca:= typObjeto.GetProperty(FieldFind(Atributo).name); //'NOME'
          strBusca := Prop.GetValue(TObject(Objeto)).ToString;

          if atributo is KeyField then
            strClausula := ' WHERE ' + FieldFind(Atributo).name + ' = ' + strBusca;

          if atributo is FieldName then
            begin
              strCampos := strCampos + FieldName(atributo).name + ' = ';

              case prop.GetValue(TObject(Objeto)).TypeInfo.Kind of
                tkWChar, tkLString, tkWString, tkString,
                tkChar, tkUString: strCampos := strCampos + #39 + strBusca + #39 + ', ';

                tkInteger: strCampos := strCampos +strBusca + ', ';

                tkFloat: strCampos := strCampos + StringReplace(strBusca, ',', '.', [rfReplaceAll]) + ', ';
              else
                raise Exception.Create('Formato n?o suportado!');
              end;
            end;
        end;
    end;

  strCampos := TrimRight(strCampos);
  strCampos := Copy(strCampos, 1, Length(strCampos) - 1);//
  strSQL := strSQL + strCampos + strClausula;

  try
    dmPrincipal. execSQL(strSQL);
    Result := True;
  except
    // silenciosa
  end;

end;

class function TDaoGenerico.valida(aSQL:String): TDataSet;
begin
  dmPrincipal.qryServidor.Close;
  dmPrincipal.qryServidor.SQL.Text := aSQL;
  dmPrincipal.qryServidor.Open;

  Result := dmPrincipal.qryServidor;
end;

end.
