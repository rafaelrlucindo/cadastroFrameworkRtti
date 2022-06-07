object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  Height = 258
  Width = 334
  object connPrincipal: TFDConnection
    ConnectionName = 'ora'
    Params.Strings = (
      'User_Name=SYSTEM'
      'Password=nas45osea'
      
        'Database=(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 192.1' +
        '68.88.130)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (S' +
        'ERVICE_NAME = XE)))'
      'MetaDefSchema=system'
      'DriverID=Ora')
    LoginPrompt = False
    Left = 56
    Top = 24
  end
  object qryServidor: TFDQuery
    Connection = connPrincipal
    Left = 152
    Top = 24
  end
  object qryGeraCodigo: TFDQuery
    Connection = connPrincipal
    Left = 232
    Top = 24
  end
  object FDPhysOracleDriverLink1: TFDPhysOracleDriverLink
    DriverID = 'Ora'
    VendorHome = 'XE'
    TNSAdmin = 'C:\Users\rafa\OneDrive\Desktop\Teste Simus\tnsnames.ora'
    Left = 56
    Top = 80
  end
end
