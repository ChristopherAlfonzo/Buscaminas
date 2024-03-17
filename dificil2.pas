program untitled;
{$codepage UTF8}//Permite usar acentos y ñ en consola.
uses crt;
const

filasfacil=8;
columnasfacil=8;
minasfacil=10;
filasintermedio=16;
columnasintermedio=16;
minasintermedio=40;
filasdificil=16;
columnasdificil=30;
minasdificil=99;

type
	tablerodificil = array[1..filasdificil, 1..columnasdificil] of integer;
	mostrarceldasD= array [1..16,1..30] of boolean;
    
var
	visibleD: mostrarceldasD;
	celdas3: tablerodificil;
	
Function max(num1,num2:integer):integer;
var
num:integer;
Begin
	if num1>num2 then
	Begin
		num:=num1;
		max:=num
	end
	else
	Begin
		num:=num2;
		max:=num	
	End;
End;

Function min(num1,num2:integer):integer;
var
num:integer;
Begin
	if num1<num2 then
	Begin
		num:=num1;
		min:=num
	end
	else
	Begin
		num:=num2;
		min:=num	
	End;
End;

procedure colocarminasD;
var
  f2,c2,i, x, y: Integer;

begin
  Randomize;
  for i := 1 to minasdificil do
  begin
    repeat
      x := Random(filasdificil) + 1;
      y := Random(columnasdificil) + 1;
    until celdas3[x, y] <> 30;
    celdas3[x, y] := 30;
  for f2 := max(1, x - 1) to min(16, x + 1) do
      begin
        for c2 := max(1, y - 1) to min(30, y + 1) do
        begin
          if celdas3[f2, c2] <> 30 then
            celdas3[f2, c2]:=celdas3[f2, c2]+1;
        end;
      end;
   end;
end;

procedure inicializarTableroD();
var
c,f: integer;
Begin
	for f:=1 to 16 do
	Begin
		For c:=1 to 30 do
		Begin
			celdas3[f,c]:=0;
		End;
	End;
	colocarminasD;
	for f:=1 to 16 do
	Begin
		For c:=1 to 30 do
		Begin
			visibleD[f,c]:= false;
		End;
	End;
End;

procedure destapar_celdasD( f,c: integer);
var
f2,c2:integer;
Begin
	if visibleD[f,c]=false then
	Begin
		visibleD[f,c]:= true;
		if celdas3[f,c]=0 then
		begin
			for f2 := max(1, f - 1) to min(16, f + 1) do
			begin
				for c2 := max(1, c - 1) to min(30, c + 1) do
				begin
					if celdas3[f2, c2] <> 30 then
						destapar_celdasD(f2, c2);
				end;
			end;
		end;
	End;
End;

function celdas_destapadasD(f,c:integer):integer;

var
num: integer;
Begin
	num:=0;
	for f:=1 to  16 do
	Begin
		for c:= 1 to 30 do
		Begin
			if visibleD[c,f] then
			Begin
				num:=num+1;
				celdas_destapadasD:=num
			End;
		End;
	End;
End;

function revisar_tableroD (c, f: integer): integer;
var
resultado:integer;

Begin
	resultado:=0;
	if celdas3[c,f]=30 then
	Begin
		visibleD[c,f]:= true;
		resultado:=-1;
	End
	else
	Begin
		destapar_celdasD(c,f);
		resultado:=celdas_destapadasD(c,f);
	end;
	revisar_tableroD:=resultado;
end;

procedure mostrar_minasD;
var
  f, c: integer;

begin
	  for f := 1 to 16 do
	  begin
		for c := 1 to 30 do
		begin
		  if celdas3[f, c] = 30 then
			visibleD[f, c]:= true;
		end;
	  end;
end;

procedure marco_dificil;
var 
    i, j: integer;
    colum: string = ('    1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30');
begin
    writeln(colum);
    for i := 1 to filasdificil do
    begin
       if i>9 then 
		Begin
			write(i,' ');
		end
		else
		Begin
			write(' ',i,' ');
		end;
        for j := 1 to columnasdificil do
        begin
            if visibleD[i,j] then
            begin
                if celdas3[i,j] = 0 then
                begin
                    write('   ');
                end
                else 
                begin 
                    if celdas3[i,j] = 30 then
                    begin
						mostrar_minasD;
                        write(' * ');
                    end
                    else
                    begin
                        write(' ',celdas3[i,j],' ');
                    end;
                end;
            end
            else
            begin
                write(' # ');
            end;
        end;
        writeln();
    end;	
end;

procedure dificil();
	Var
	f,c,resultado: integer;
Begin
	inicializarTableroD;
	repeat
	Begin
		marco_dificil;
		//Pedir fila y columna de casilla a destapar
		repeat
		Begin
			Writeln('Indica fila entre el 1 al 16:');
			readln(f);
		End;
		until (f>=1) and (f<=16);
		repeat
		Begin
			Writeln('Indica una columna entre el 1 al 30:');
			readln(c);
		End;
		until (c>=1) and (c<=30) ;
		
		//Comprobamos el tablero

		resultado:=revisar_tableroD(f,c);
		clrscr;
	End;
	until (resultado=-1) or (resultado=351);
	marco_dificil;
//Has destapado una mina
	if resultado=-1 then
	Begin
		mostrar_minasD;
		writeln('Has pisado una mina');
		Writeln('¡¡¡HAS PERDIDO!!!');
	End
	//has destapado todas las casillas
	else
	Begin
		Writeln('Has completado el juego sin pisar una mina');
		Writeln('¡¡¡FELICIDADES!!!');
	End;

End;

BEGIN
	dificil;
	readln();
END.
