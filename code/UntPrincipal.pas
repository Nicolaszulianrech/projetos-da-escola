unit UntPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Math;

type
  TForm2 = class(TForm)
    StringGrid1: TStringGrid;
    procedure StringGrid1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[1, 1] := ' #';
end;

procedure TForm2.StringGrid1Click(Sender: TObject);
var
  Linha: Integer;
  Coluna: Integer;
  flag: Integer;
  contL: Integer;
  contC: Integer;
  M: Array [1 .. 3, 1 .. 3] of Integer;
  contS: Integer;
  contP: Integer;

begin

  // Adiciona o X do jogador na posição (Apenas se estiver vazia)
  if (StringGrid1.Cells[StringGrid1.Col, StringGrid1.Row] = '') then
  begin

    // [OK] Adiciona jogada do usuário
    StringGrid1.Cells[StringGrid1.Col, StringGrid1.Row] := ' X';

    // [OK] Carrega matriz para realizar os testes
    for Linha := 1 to 3 do // Laço que percorre as linhas
    begin
      for Coluna := 1 to 3 do // Laço que percorre as colunas
      begin

        if (StringGrid1.Cells[Coluna - 1, Linha - 1] = ' X') then
        begin
          M[Linha, Coluna] := 0; // Carrega com 0 a matriz se encontrar X
        end
        else if (StringGrid1.Cells[Coluna - 1, Linha - 1] = ' #') then
        begin
          M[Linha, Coluna] := 1; // Carrega com 1 a matriz se encontrar #
        end
        else
        begin
          M[Linha, Coluna] := -1;
        end;
      end;

    end;

    // [OK] Verifica se o jogo empatou
    ContP := 0;
    for Linha := 1 to 3 do
    begin
      for Coluna := 1 to 3 do
      begin
        if(M[Linha,Coluna] <> -1) then
        begin
          ContP := ContP + 1;
        end;
      end;
    end;
    if(ContP = 9) then
    begin

      showmessage('O Jogo Terminou Empatado!');
      showmessage('Obrigado por Jogar o GAME do CETEC!');
      close();

    end;

    // [OK] Verifica se jogo acabou para o usuário
    flag := 0;

    // 1. Verifica no sentido linha + coluna por #
    for Linha := 1 to 3 do
    begin
      contL := 0;
      contC := 0;
      for Coluna := 1 to 3 do
      begin

        if (M[Linha, Coluna] = 0) then
        begin
          contL := contL + 1;
        end;
        if (M[Coluna, Linha] = 0) then
        begin
          contC := contC + 1;
        end;

      end;
      if ((contL = 3) OR (contC = 3)) then
      begin
        flag := 1;
      end;
    end;

    // 3. Verifica a diagonal principal e secundária por #
    for Linha := 1 to 3 do
    begin
      contP := 0;
      contS := 0;
      for Coluna := 1 to 3 do
      begin

        if (Linha = Coluna) then // Está encima da diagonal principal
        begin

          if (M[Linha, Coluna] = 0) then
          begin
            contP := contP + 1;
          end;

        end;

        if (Coluna = 4 - Linha) then // Está encima da diagonal secundaria
        begin

          if (M[Linha, Coluna] = 0) then
          begin
            contS := contS + 1;
          end;

        end;

      end;
      if ((contP = 3) OR (contS = 3)) then
      begin
        flag := 1;
      end;
    end;

    if (flag = 1) then
    begin

      showmessage('O Usuário Ganhou o Jogo!');
      showmessage('Obrigado por Jogar o GAME do CETEC!');
      close();

    end
    else
    begin

      // [OK] Faz jogada do computador

      flag := 0;
      while flag = 0 do
      begin

        Linha := RandomRange(1, 4);
        Coluna := RandomRange(1, 4);
        if ((M[Linha, Coluna] = -1)) then
        begin

          M[Linha, Coluna] := 1; // Define posição de jogada do computador
          flag := 1; // Flag recebe 1 para parar o laço

        end;

      end;

      // [OK] Verifica se jogo acabou para o computador

      flag := 0;

      // 1. Verifica no sentido linha + coluna por #
      for Linha := 1 to 3 do
      begin
        contL := 0;
        contC := 0;
        for Coluna := 1 to 3 do
        begin

          if (M[Linha, Coluna] = 1) then
          begin
            contL := contL + 1;
          end;
          if (M[Coluna, Linha] = 1) then
          begin
            contC := contC + 1;
          end;

        end;
        if ((contL = 3) OR (contC = 3)) then
        begin
          flag := 1;
        end;
      end;

      // 3. Verifica a diagonal principal e secundária por #
      for Linha := 1 to 3 do
      begin
        contP := 0;
        contS := 0;
        for Coluna := 1 to 3 do
        begin

          if (Linha = Coluna) then // Está encima da diagonal principal
          begin

            if (M[Linha, Coluna] = 1) then
            begin
              contP := contP + 1;
            end;

          end;

          if (Coluna = 4 - Linha) then // Está encima da diagonal secundaria
          begin

            if (M[Linha, Coluna] = 1) then
            begin
              contS := contS + 1;
            end;

          end;

        end;
        if ((contP = 3) OR (contS = 3)) then
        begin
          flag := 1;
        end;
      end;

    end;

    // [OK] Carrega grid novamente com os novos valores da matriz

    for Linha := 1 to 3 do // Laço que percorre as linhas
    begin
      for Coluna := 1 to 3 do // Laço que percorre as colunas
      begin

        if M[Linha, Coluna] = 0 then // Carrega com 0 a matriz se encontrar X
        begin

          StringGrid1.Cells[Coluna - 1, Linha - 1] := ' X';

        end
        else if M[Linha, Coluna] = 1 then // Carrega com 1 a matriz se encontrar #
        begin

          StringGrid1.Cells[Coluna - 1, Linha - 1] := ' #';

        end;
      end;

    end;

    if (flag = 1) then // flag estará em 1 se PC ganhou
    begin

      showmessage('O Computador Ganhou o Jogo!');
      showmessage('Obrigado por Jogar o GAME do CETEC!');
      close();

    end;

    // [OK] Verifica se o jogo empatou
    ContP := 0;
    for Linha := 1 to 3 do
    begin
      for Coluna := 1 to 3 do
      begin
        if(M[Linha,Coluna] <> -1) then
        begin
          ContP := ContP + 1;
        end;
      end;
    end;
    if(ContP = 9) then
    begin

      showmessage('O Jogo Terminou Empatado!');
      showmessage('Obrigado por Jogar o GAME do CETEC!');
      close();

    end;

  end
  else
  begin
    showmessage('Posição já foi jogada!');
  end;

end;

end.
