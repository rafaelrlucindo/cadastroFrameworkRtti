inherited frmProduto: TfrmProduto
  Caption = 'Cadastro de Produto'
  ClientHeight = 574
  ClientWidth = 845
  Position = poScreenCenter
  ExplicitWidth = 851
  ExplicitHeight = 603
  PixelsPerInch = 96
  TextHeight = 13
  inherited ToolBar1: TToolBar
    Width = 845
    ExplicitWidth = 845
  end
  inherited pnlPrincipal: TPanel
    Width = 845
    Height = 496
    ExplicitWidth = 845
    ExplicitHeight = 496
    inherited pnlDados: TPanel
      Left = 336
      Width = 508
      Height = 494
      ExplicitLeft = 336
      ExplicitWidth = 508
      ExplicitHeight = 494
      object Label1: TLabel [0]
        Left = 78
        Top = 52
        Width = 11
        Height = 13
        Caption = 'ID'
      end
      object Label2: TLabel [1]
        Left = 77
        Top = 132
        Width = 140
        Height = 13
        Caption = 'DESCRI'#199#195'O DO PRODUTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel [2]
        Left = 78
        Top = 215
        Width = 35
        Height = 13
        Caption = 'ATIVO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited shpGridZebra: TShape
        Left = 14
        Top = 145
        ExplicitLeft = 14
        ExplicitTop = 145
      end
      inherited shpGridSel: TShape
        Left = 14
        Top = 167
        ExplicitLeft = 14
        ExplicitTop = 167
      end
      object Label3: TLabel
        Left = 78
        Top = 89
        Width = 72
        Height = 13
        Caption = 'FORNECEDOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 77
        Top = 173
        Width = 113
        Height = 13
        Caption = 'PRE'#199'O UNIT'#193'RIO R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtID: TEdit
        Left = 78
        Top = 65
        Width = 96
        Height = 21
        TabStop = False
        Color = 16770756
        ReadOnly = True
        TabOrder = 0
        OnEnter = edtBuscaEnter
        OnExit = edtBuscaExit
      end
      object edtDescricao: TEdit
        Left = 78
        Top = 146
        Width = 363
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 80
        TabOrder = 3
        OnEnter = edtBuscaEnter
        OnExit = edtBuscaExit
      end
      object edtSTATUS: TComboBox
        Left = 78
        Top = 230
        Width = 106
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 5
        OnEnter = edtBuscaEnter
        OnExit = edtBuscaExit
        Items.Strings = (
          'SIM'
          'N'#195'O')
      end
      object edtPreco_Unitario: TcxCurrencyEdit
        Left = 78
        Top = 188
        Properties.AssignedValues.EditFormat = True
        TabOrder = 4
        Width = 106
      end
      object edtNomeFornecedorIgnore: TEdit
        Left = 177
        Top = 102
        Width = 264
        Height = 21
        TabStop = False
        CharCase = ecUpperCase
        ReadOnly = True
        TabOrder = 2
        OnEnter = edtBuscaEnter
        OnExit = edtBuscaExit
      end
      object edtIdFornecedor: TEdit
        Left = 78
        Top = 102
        Width = 96
        Height = 21
        Hint = '( Ctrl + Enter ou Dois Clicks aqui )  Busca por Fornecedor'
        Color = clWhite
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnChange = edtIdFornecedorChange
        OnDblClick = edtIdFornecedorDblClick
        OnEnter = edtBuscaEnter
        OnExit = edtBuscaExit
      end
    end
    inherited pnlGrid: TPanel
      Width = 335
      Height = 494
      ExplicitWidth = 335
      ExplicitHeight = 494
      inherited GroupBox1: TGroupBox
        Width = 333
        ExplicitWidth = 333
        inherited btnBuscar: TSpeedButton
          Left = 168
          Top = 17
          Width = 28
          Height = 23
          ExplicitLeft = 168
          ExplicitTop = 17
          ExplicitWidth = 28
          ExplicitHeight = 23
        end
        inherited edtBusca: TEdit
          Top = 18
          Width = 158
          ExplicitTop = 18
          ExplicitWidth = 158
        end
      end
      inherited dbgPadrao: TDBGrid
        Width = 333
        Height = 441
        Color = clWhite
        DataSource = dsPadrao
        Columns = <
          item
            Expanded = False
            FieldName = 'NOME'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 208
            Visible = True
          end
          item
            Color = 16770756
            Expanded = False
            FieldName = 'PRECO_UNITARIO'
            Title.Caption = 'PRECO R$'
            Width = 85
            Visible = True
          end>
      end
    end
  end
end
