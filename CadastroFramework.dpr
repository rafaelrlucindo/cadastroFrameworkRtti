program CadastroFramework;

uses
  Vcl.Forms,
  untDmPrincipal in 'untDmPrincipal.pas' {dmPrincipal: TDataModule},
  untMenu in 'untMenu.pas' {frmMenu},
  untPadrao in 'untPadrao.pas' {frmPadrao},
  untCliente in 'untCliente.pas' {frmCliente},
  untFornecedor in 'untFornecedor.pas' {frmFornecedor},
  untProduto in 'untProduto.pas' {frmProduto},
  untDaoGenerico in 'Framework\untDaoGenerico.pas',
  untEntidadeAtributos in 'Framework\untEntidadeAtributos.pas',
  untEntidadeGenerica in 'Framework\untEntidadeGenerica.pas',
  untClassCliente in 'Framework\untClassCliente.pas',
  untClassFornecedor in 'Framework\untClassFornecedor.pas',
  untClassProduto in 'Framework\untClassProduto.pas',
  untRelCliente in 'Reports\untRelCliente.pas' {frmRelCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmRelCliente, frmRelCliente);
  Application.CreateForm(TfrmRelCliente, frmRelCliente);
  Application.Run;
end.
