program prototipo;
	
procedure InicializarTablero(var celdas: integer;var portada:boolean);
Var
c,f: integer;

Begin

	//Incializo el tablero con valor 0
	for f:=1 to 8 do
	Begin
		For c:=1 to 8 do
		Begin
			celdas[c,f]:=0;
		End;
	End;
	PonerMinas(celdas);
	//Incializo la tabla visible a falso indicando que ninguna celda está descubierta
	For f:=1 to 8 do
	Begin
		For c:=1 to 8 do
		Begin
			portada[f,c]:= false;
		End;
	End;
	
End;
Function PonerMinas(celdas: integer): integer;
var
 num_minas,f,c,f2,c2: integer;
Begin
	num_minas:=0;
	//Vamos a poner 10 minas en el tablero
	Repeat
	Begin
		//Me aseguro que no haya ya una mina en la posición que se genera aleatoriamente
		repeat
		Begin
			randomize;
			f:=random(8)+1;
			c:=random(8)+1;
		end;
		until celdas[f,c]<>8;
		//Reperesentamos la mina con el número 9
		celdas[f,c]:=9;
		//Ahora incremento el número de minas cercanas en las casillas vecinas
		for f2:=max(1,f-1) to min(8, f+1) do
		Begin
			for c2:=max(1,c-1) to min(8, c+1) do
			Begin
				if celdas[f2, c2]<>8 then
				Begin
					celdas[f2,c2]:=celdas[f2,c2]+1;
				End;
			end;
		End;
		num_minas:=num_minas+1;
	End;
	until(num_minas>10);
End;
procedure DestaparCelda(tablero Por Referencia,visible Por Referencia,f,c)
Var
f2,c2: integer;
Begin
	//Si es una casilla que se puede destapar
	if visible[fila,colum]=False then
	Begin
		visible[fila,colum]:= true;
		//Si no hay minas cerca tengo que intentar destapar las vecinas
		if tablero[f,c]=0 then
		Begin
			for f2 <- max(1,fila-1) to min(8, f+1) do
			Begin
				for colum2 <- max(1,colum-1) to min(8, colum+1) do
				Begin
					if tablero[f2, c2]<>8 then
					Begin
						DestaparCelda(tablero,visible,fila2,colum2);
					End;
				End;
			End;
		End;
	End;
End;
Function  ContarCeldasDestapadas(visible)
Var
 num,fila,colum:integer;
 Begin
	num:=0;
	for f:=0 to 9 do
	Begin
		for c:=0 to 9 do
		Begin
			if visible[f,c] then
			Begin
				num:=num+1;
			End;
		End;
	End;
end; 
procedure resultado:=ComprobarTablero(tablero Por Referencia,visible por referencia,fila,colum)
Var
fin:integer;
Begin
	//Si es una mina devuelvo -1
	if tablero[fila,colum]=9 then
	begin
		//Destapo la celda con la mina
		visible[fila,colum]:=true;
		resultado:= -1;
	End
	else
	Begin
		DestaparCelda(tablero,visible,fila,colum);
		fin:=ContarCeldasDestapadas(visible);
	end;
end;
Funcion EscribirTablero(tablero,visible)
	Var
	 f,c: integer;
Begin
	//Recorro las tablas
	For f:=1 to 8 do
	Begin
		For c:=1 to 8 do
			//Si la celda es visible (está destapada)
			if visible[f,c] then
			Begin
				//Celda que no tiene minas alrededor
				if tablero[f,c]=0 then
				Begin
					writeln('  ');
				End
				else
				Begin
					//Es una mina
					if tablero[f,c]=9 then
					Begin
						Writeln('* ');
					end
					//Muestro el número de minas que hay en los vecinos	
					else
					Begin
						writelnr(tablero[fila,colum],' ');
					end
				end
			//La casilla no es visible
			else
			begin
				writeln( sin Saltar "# ";
			End;
		End;
		write('');
	End;
End;

procedure Facil();
	Var
	f,c,resultado: integer;
Begin
	InicializarTablero(celdas,portada);
	repeat
	Begin
		mostrarceldas(celdas,portada);
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
		resultado:=ComprobarTablero(celdas,portada,f,c);
		clrscr;
	End;
	until resultado=-1 or resultado=90;
	mostarceldas(celdas,portada);
	//Has destapado una mina
	if resultado=-1 then
	Begin
		ponerminas(celdas);
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
