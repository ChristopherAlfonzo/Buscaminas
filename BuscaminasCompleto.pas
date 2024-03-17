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
	mostrarceldasf= array [1..8,1..8] of boolean;
	tablerointermedio = array[1..filasintermedio, 1..columnasintermedio] of integer;
	mostrarceldasI= array [1..16,1..16] of boolean;
	tablerodificil = array[1..filasdificil, 1..columnasdificil] of integer;
	mostrarceldasD= array [1..16,1..30] of boolean;
    
var
	visiblef: mostrarceldasf;
	celdas1: tablerofacil;
	visibleI: mostrarceldasI;
	celdas2: tablerointermedio;
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



procedure colocarminasF;
var
  f2,c2,i, x, y: Integer;

begin
  Randomize;
  for i := 1 to minasfacil do
  begin
    repeat
      x := Random(filasfacil) + 1;
      y := Random(columnasfacil) + 1;
    until celdas1[x, y] <> 8;
    celdas1[x, y] := 8;
  for f2 := max(1, x - 1) to min(8, x + 1) do
      begin
        for c2 := max(1, y - 1) to min(8, y + 1) do
        begin
          if celdas1[f2, c2] <> 8 then
            celdas1[f2, c2]:=celdas1[f2, c2]+1;
        end;
      end;
   end;
end;

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

procedure inicializarTableroF();
var
c,f: integer;
Begin
	for f:=1 to 8 do
	Begin
		For c:=1 to 8 do
		Begin
			celdas1[f,c]:=0;
		End;
	End;
	colocarminasF;
	for f:=1 to 8 do
	Begin
		For c:=1 to 8 do
		Begin
			visiblef[f,c]:= false;
		End;
	End;
End;

procedure inicializarTableroI();
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

procedure destapar_celdasF( f,c: integer);
var
f2,c2:integer;
Begin
	if visiblef[f,c]=false then
	Begin
		visiblef[f,c]:= true;
		if celdas1[f,c
		]=0 then
		begin
			for f2 := max(1, f - 1) to min(8, f + 1) do
			begin
				for c2 := max(1, c - 1) to min(8, c + 1) do
				begin
					if celdas1[f2, c2] <> 8 then
						destapar_celdasF(f2, c2);
				end;
			end;
		end;
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

function celdas_destapadasF(f,c:integer):integer;

var
num: integer;
Begin
	num:=0;
	for f:=1 to  8 do
	Begin
		for c:= 1 to 8 do
		Begin
			if visiblef[c,f] then
			Begin
				num:=num+1;
				celdas_destapadasF:=num
		
			End;
		End;
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

function revisar_tableroF (c, f: integer): integer;
var
resultado:integer;

Begin
	resultado:=0;
	if celdas1[c,f]=8 then
	Begin
		visiblef[c,f]:= true;
		resultado:=-1;
	End
	else
	Begin
		destapar_celdasF(c,f);
		resultado:=celdas_destapadasF(c,f);
	end;
	revisar_tableroF:=resultado;
end;

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

procedure mostrar_minasf;
var
  f, c: integer;

begin
	  for f := 1 to 8 do
	  begin
		for c := 1 to 8 do
		begin
		  if celdas1[f, c] = 8 then
			visiblef[f, c]:= true;
		end;
	  end;
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
            if visiblef[i,j] then
            begin
                if celdas1[i,j] = 0 then
                begin
                    write('  ');
                end
                else 
                begin 
                    if celdas1[i,j] = 8 then
                    begin
						mostrar_minasf;
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

procedure Facil();
	Var
	f,c,resultado: integer;
Begin
	inicializarTableroF;
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
		resultado:=revisar_tableroF(f,c);
		clrscr;
	End;
	until (resultado=-1) or (resultado=54);
	marco_facil;
//Has destapado una mina
	if resultado=-1 then
	Begin
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

procedure intermedio();
	Var
	f,c,resultado: integer;
Begin
	inicializarTableroI;
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

var 
opcion, decision, difilcultad: char;

BEGIN
	
	Repeat
	Begin
		Repeat
		Begin
			writeln('Bienvenido al juego de Buscaminas');
			Writeln('Presione 1 para Jugar');
			Writeln('Presione 2 para salir');
			Readln(opcion);
			clrscr;
		End;
		until (opcion>'1') or (opcion<'3');//evita que se elija una opcion que no exite
		if(opcion='1') then
			Begin
				Repeat
				Begin
					Writeln('usted ha elegido la opcion de jugar');
					Writeln('Elija la difilcutad que quiere jugar');
					Writeln('1. Facil');
					Writeln('2. Intermedio');
					writeln('3. Dificil');
					readln(difilcultad);
					clrscr;
				End;
				until (difilcultad>'1') or (difilcultad<'4');//evita que se elija una difilcultad que no existe, pero te devuelve al inicio del programa
				case difilcultad of
					'1': begin
						Writeln('usted ha elegido la difilcultad facil');
						writeln('Diviertase');
						readkey;
						clrscr;
						repeat
							Begin
								Facil;
								writeln('Ha terminado la partida');
								writeln('1.Si quiere volver a la pantalla de inicio');
								writeln('Presione cualquier otra tecla para ir al menu principal');
								readln(decision);
								clrscr;
							End;
						until (decision='1');//para que el usuario decida si quiere volver a jugar o quiere reiniciar el programa
					End;
					'2': begin
						Writeln('usted ha elegido la difilcultad media');
						writeln('Diviertase');
						readkey;
						clrscr;
						repeat
							Begin
								intermedio;
								writeln('Ha terminado la partida');
								writeln('1.Si quiere volver a la pantalla de inicio');
								writeln('Presione cualquier otra tecla para ir al menu principal');
								readln(decision);
								clrscr;
							End;
						until (decision='1');//para que el usuario decida si quiere volver a jugar o quiere reiniciar el programa
					End;
					'3': begin
							Writeln('usted ha elegido la difilcultad dificil');
							writeln('Diviertase');
							readkey;
							clrscr;
							repeat
							Begin
								dificil;
								writeln('Ha terminado la partida');
								writeln('1.Si quiere volver a la pantalla de inicio');
								writeln('Presione cualquier otra tecla para ir al menu principal');
								readln(decision);
								clrscr;
							End;
						until (decision='1')//para que el usuario decida si quiere volver a jugar o quiere reiniciar el programa 
					End;
				End;
			End;
	End;
	until (opcion='2');
END.

