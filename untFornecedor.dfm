inherited frmFornecedor: TfrmFornecedor
  Caption = 'Cadastro de Fornecedor'
  ClientHeight = 539
  ClientWidth = 830
  Position = poScreenCenter
  ExplicitWidth = 836
  ExplicitHeight = 568
  PixelsPerInch = 96
  TextHeight = 13
  inherited ToolBar1: TToolBar
    Width = 830
    ExplicitWidth = 830
  end
  inherited pnlPrincipal: TPanel
    Width = 830
    Height = 461
    ExplicitWidth = 830
    ExplicitHeight = 461
    inherited pnlDados: TPanel
      Width = 621
      Height = 459
      ExplicitWidth = 621
      ExplicitHeight = 459
      object Label1: TLabel [0]
        Left = 78
        Top = 52
        Width = 11
        Height = 13
        Caption = 'ID'
      end
      object Label2: TLabel [1]
        Left = 78
        Top = 92
        Width = 31
        Height = 13
        Caption = 'NOME'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel [2]
        Left = 277
        Top = 52
        Width = 27
        Height = 13
        Caption = 'CNPJ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel [3]
        Left = 78
        Top = 134
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
      object edtNOME: TEdit
        Left = 78
        Top = 106
        Width = 363
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 2
        OnEnter = edtBuscaEnter
        OnExit = edtBuscaExit
      end
      object edtCNPJ: TEdit
        Left = 277
        Top = 65
        Width = 164
        Height = 21
        NumbersOnly = True
        TabOrder = 1
        OnEnter = edtBuscaEnter
        OnExit = edtBuscaExit
      end
      object edtSTATUS: TComboBox
        Left = 78
        Top = 148
        Width = 106
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 3
        OnEnter = edtBuscaEnter
        OnExit = edtBuscaExit
        Items.Strings = (
          'SIM'
          'N'#195'O')
      end
    end
    inherited pnlGrid: TPanel
      Height = 459
      ExplicitHeight = 459
      inherited GroupBox1: TGroupBox
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
        Height = 406
        DataSource = dsPadrao
        Columns = <
          item
            Expanded = False
            FieldName = 'NOME'
            Width = 166
            Visible = True
          end>
      end
    end
  end
  inherited dsPadrao: TDataSource
    Left = 128
    Top = 271
  end
  inherited dspPadrao: TDataSetProvider
    ResolveToDataSet = True
    Left = 128
    Top = 223
  end
  inherited cdsPadrao: TClientDataSet
    Left = 128
    Top = 175
  end
end
