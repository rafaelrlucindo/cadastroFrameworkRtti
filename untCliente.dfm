inherited frmCliente: TfrmCliente
  Caption = 'Cadastro de Cliente'
  ClientHeight = 541
  ClientWidth = 816
  Position = poScreenCenter
  ExplicitWidth = 822
  ExplicitHeight = 570
  PixelsPerInch = 96
  TextHeight = 13
  inherited ToolBar1: TToolBar
    Width = 816
    ExplicitWidth = 816
  end
  inherited pnlPrincipal: TPanel
    Width = 816
    Height = 463
    ExplicitWidth = 816
    ExplicitHeight = 463
    inherited pnlDados: TPanel
      Width = 607
      Height = 461
      ExplicitWidth = 607
      ExplicitHeight = 461
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
        Width = 20
        Height = 13
        Caption = 'CPF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel [3]
        Left = 78
        Top = 181
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
      object Label5: TLabel [4]
        Left = 78
        Top = 135
        Width = 106
        Height = 13
        Caption = 'DATA NASCIMENTO'
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
      object edtCPF: TEdit
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
        Top = 195
        Width = 106
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 4
        OnEnter = edtBuscaEnter
        OnExit = edtBuscaExit
        Items.Strings = (
          'SIM'
          'N'#195'O')
      end
      object edtData_Nascimento: TcxDateEdit
        Left = 78
        Top = 154
        TabOrder = 3
        Width = 106
      end
    end
    inherited pnlGrid: TPanel
      Height = 461
      ExplicitHeight = 461
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
        Height = 408
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
