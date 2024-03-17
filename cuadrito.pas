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
	tablerointermedio = array[1..filasintermedio, 1..columnasintermedio] of integer;
	mostrarceldasI= array [1..16,1..16] of boolean;
    
var
	visibleI: mostrarceldasI;
	celdas2: tablerointermedio;
	
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

procedure colocarminasI;
var
  f2,c2,i, x, y: Integer;

begin
  Randomize;
  for i := 1 to minasintermedio do
  begin
    repeat
      x := Random(filasintermedio) + 1;
      y := Random(columnasintermedio) + 1;
    until celdas2[x, y] <> 16;
    celdas2[x, y] := 16;
  for f2 := max(1, x - 1) to min(16, x + 1) do
      begin
        for c2 := max(1, y - 1) to min(16, y + 1) do
        begin
          if celdas2[f2, c2] <> 16 then
            celdas2[f2, c2]:=celdas2[f2, c2]+1;
        end;
      end;
   end;
end;

procedure inicializarTablero();
var
c,f: integer;
Begin
	for f:=1 to 16 do
	Begin
		For c:=1 to 16 do
		Begin
			celdas2[f,c]:=0;
		End;
	End;
	colocarminasI;
	for f:=1 to 16 do
	Begin
		For c:=1 to 16 do
		Begin
			visibleI[f,c]:= false;
		End;
	End;
End;

procedure destapar_celdasI( f,c: integer);
var
f2,c2:integer;
Begin
	if visibleI[f,c]=false then
	Begin
		visibleI[f,c]:= true;
		if celdas2[f,c]=0 then
		begin
			for f2 := max(1, f - 1) to min(16, f + 1) do
			begin
				for c2 := max(1, c - 1) to min(16, c + 1) do
				begin
					if celdas2[f2, c2] <> 16 then
						destapar_celdasI(f2, c2);
				end;
			end;
		end;
	End;
End;

function celdas_destapadasI(f,c:integer):integer;

var
num: integer;
Begin
	num:=0;
	for f:=1 to  16 do
	Begin
		for c:= 1 to 16 do
		Begin
			if visibleI[c,f] then
			Begin
				num:=num+1;
				celdas_destapadasI:=num
			End;
		End;
	End;
End;

function revisar_tableroI (c, f: integer): integer;
var
resultado:integer;

Begin
	resultado:=0;
	if celdas2[c,f]=16 then
	Begin
		visibleI[c,f]:= true;
		resultado:=-1;
	End
	else
	Begin
		destapar_celdasI(c,f);
		resultado:=celdas_destapadasI(c,f);
	end;
	revisar_tableroI:=resultado;
end;

procedure mostrar_minasI;
var
  f, c: integer;

begin
	  for f := 1 to 16 do
	  begin
		for c := 1 to 16 do
		begin
		  if celdas2[f, c] = 16 then
			visibleI[f, c]:= true;
		end;
	  end;
end;

procedure marco_intermedio;
var 
    i, j: integer;
    colum: string = ('    1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16');
begin
    writeln(colum);
    for i := 1 to filasintermedio do
    begin
       if i>9 then 
		Begin
			write(i,' ');
		end
		else
		Begin
			write(' ',i,' ');
		end;
        for j := 1 to columnasintermedio do
        begin
            if visibleI[i,j] then
            begin
                if celdas2[i,j] = 0 then
                begin
                    write('   ');
                end
                else 
                begin 
                    if celdas2[i,j] = 16 then
                    begin
						mostrar_minasI;
                        write(' * ');
                    end
                    else
                    begin
                        write(' ',celdas2[i,j],' ');
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

procedure intermedio();
	Var
	f,c,resultado: integer;
Begin
	inicializarTablero;
	repeat
	Begin
		marco_intermedio;
		//Pedir fila y columna de casilla a destapar
		repeat
		Begin
			Writeln('Indica fila entre el 1 al 16:');
			readln(f);
		End;
		until (f>=1) and (f<=16);
		repeat
		Begin
			Writeln('Indica una columna entre el 1 al 16:');
			readln(c);
		End;
		until (c>=1) and (c<=16) ;
		
		//Comprobamos el tablero

		resultado:=revisar_tableroI(f,c);
		clrscr;
	End;
	until (resultado=-1) or (resultado=216);
	marco_intermedio;
//Has destapado una mina
	if resultado=-1 then
	Begin
		mostrar_minasI;
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
	intermedio;
	readln();
END.
