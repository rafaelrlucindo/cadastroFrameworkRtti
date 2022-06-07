unit untMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  untCliente, Vcl.StdCtrls, Vcl.Buttons, untFornecedor, untProduto,
  untRelCliente;

type
  TfrmMenu = class(TForm)
    mmPrincipal: TMainMenu;
    mniManutencao: TMenuItem;
    mnClientes: TMenuItem;
    mnSepara: TMenuItem;
    mniFornecedor: TMenuItem;
    Produto1: TMenuItem;
    mniProdutos: TMenuItem;
    mnRelatrios1: TMenuItem;
    mniRelCli: TMenuItem;
    stat1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    btnCliente: TBitBtn;
    btnFornecedor: TBitBtn;
    btnProduto: TBitBtn;
    btnVendas: TBitBtn;
    btnRelatorios: TBitBtn;
    btnSair: TBitBtn;
    Label2: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure btnClienteClick(Sender: TObject);
    procedure mnClientesClick(Sender: TObject);
    procedure mniFornecedorClick(Sender: TObject);
    procedure mniProdutosClick(Sender: TObject);
    procedure btnProdutoClick(Sender: TObject);
    procedure btnFornecedorClick(Sender: TObject);
    procedure mniRelCliClick(Sender: TObject);
    procedure btnRelatoriosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.dfm}

procedure TfrmMenu.btnClienteClick(Sender: TObject);
begin
  mnClientesClick(Sender);
end;

procedure TfrmMenu.btnFornecedorClick(Sender: TObject);
begin
  mniFornecedorClick(Sender);
end;

procedure TfrmMenu.btnProdutoClick(Sender: TObject);
begin
  mniProdutosClick(Sender);
end;

procedure TfrmMenu.btnRelatoriosClick(Sender: TObject);
begin
  mniRelCliClick(Self);
end;

procedure TfrmMenu.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMenu.mnClientesClick(Sender: TObject);
begin
  with TfrmCliente.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrmMenu.mniFornecedorClick(Sender: TObject);
begin
  with TfrmFornecedor.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrmMenu.mniProdutosClick(Sender: TObject);
begin
  with TfrmProduto.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrmMenu.mniRelCliClick(Sender: TObject);
begin
  with TfrmRelCliente.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

end.
