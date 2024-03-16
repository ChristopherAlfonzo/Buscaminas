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
	tablerofacil = array[1..filasfacil, 1..columnasfacil] of integer;
	tablerointermedio = array[1..filasintermedio, 1..columnasintermedio] of Char;
	tablerodificil = array[1..filasdificil, 1..columnasdificil] of Char;
	mostrarceldas= array [1..8,1..8] of boolean;
    
var
	visible: mostrarceldas;
	celdas1: tablerofacil;
	celdas2: tablerointermedio;
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


procedure colocarminas;
var
  i, x, y: Integer;

begin
  Randomize;
  for i := 1 to minasfacil do
  begin
    repeat
      x := Random(filasfacil) + 1;
      y := Random(columnasfacil) + 1;
    until celdas1[x, y] <> 8;
    celdas1[x, y] := 8;
  end;
end;

procedure inicializarTablero();
var
c,f: integer;
Begin
	for c:=1 to 8 do
	Begin
		For f:=1 to 8 do
		Begin
			celdas1[c,f]:=0;
			
		End;
	End;
	colocarminas;
	for c:=1 to 8 do
	Begin
		For f:=1 to 8 do
		Begin
			visible[c,f]:= false;
		End;
	End;
End;

procedure destapar_celdas(var c,f: integer);
var
f2,c2:integer;
Begin
	if visible[c,f]=false then
	Begin
		visible[c,f]:= true;
		if celdas1[c,f]=0 then
		begin
			for f2:=max(1,f-1) to min(8,f+1) do 
			begin
				for c2:=max(1,c-1) to min(8,c+1) do 
				begin
					if celdas1[f2,c2] then
					begin
						destapar_celdas(f2,c2);
					end;
				end;
			end;
		end;
	End;
End;

function celdas_destapadas(f,c:integer):integer;

var
num: integer;
Begin
	num:=0;
	for f:=1 to  8 do
	Begin
		for c:= 1 to 8 do
		Begin
			if visible[c,f] then
			Begin
				num:=num+1;
				celdas_destapadas:=num
		
			End;
		End;
	End;
End;

function revisar_tablero (c, f: integer): integer;
var
resultado:integer;

Begin
	resultado:=0;
	if celdas1[c,f]=9 then
	Begin
		visible[c,f]:= true;
		resultado:=-1;
	End
	else
	Begin
		destapar_celdas(c,f);
		resultado:=celdas_destapadas(c,f);
	end;
	revisar_tablero:=resultado;
end;

procedure marco_facil;
var 
    i, j: integer;
    colum: string = ('  1 2 3 4 5 6 7 8');
begin
    writeln(colum);
    for i := 1 to filasfacil do
    begin
        write(i,' ');
        for j := 1 to columnasfacil do
        begin
            if visible[i,j] then
            begin
                if celdas1[i,j] = 0 then
                begin
                    write('  ');
                end
                else 
                begin 
                    if celdas1[i,j] = 8 then
                    begin
                        write('* ');
                    end
                    else
                    begin
                        write(celdas1[i,j],' ');
                    end;
                end;
            end
            else
            begin
                write('# ');
            end;
        end;
        writeln();
    end;	
end;

procedure marco_intermedio;
var i,j:integer;

begin
	for i:=1 to 16 do
	begin
		for j:=1 to 16 do
		begin
			write('# ');
		end;
		writeln();
	end;	
end;

procedure marco_dificil;
var i,j:integer;

begin
	for i:=1 to 16 do
	begin
		for j:=1 to 30 do
		begin
			write('# ');
		end;
		writeln();
	end;	
end;

procedure Facil();
	Var
	f,c,resultado: integer;
Begin
	inicializarTablero;
	repeat
	Begin
		marco_facil;
		//Pedir fila y columna de casilla a destapar
		repeat
		Begin
			Writeln('Indica fila entre el 1 al 8:');
			readln(f);
		End;
		until (f>=1) and (f<=8);
		repeat
		Begin
			Writeln('Indica una columna entre el 1 al 8:');
			readln(c);
		End;
		until (c>=1) and (c<=8) ;
		
		//Comprobamos el tablero

		//resultado:=ComprobarTablero(celdas,portada,f,c);
		resultado:=revisar_tablero(f,c);
		clrscr;
	End;
	until (resultado=-1) or (resultado=54);
	marco_facil;
//Has destapado una mina
	if resultado=-1 then
	Begin
		colocarminas;
		writeln('Has pisado una mina');
		Writeln('¡¡¡HAS PERDIDO');
	End
	//has destapado todas las casillas
	else
	Begin
		Writeln('Has completado el juego sin pisar una mina');
		Writeln('¡¡¡FELICIDADES!!!');
	End;

End;

BEGIN
	facil;

{
	marco_intermedio;

	writeln();
	marco_dificil;
	}
	readln();
END.
