
program untitled;


var 
opcion, difilcultad: char;

BEGIN
	
	Repeat
	Begin
		writeln('Bienvenido al juego de Buscaminas');
		Writeln('Presione 1 para Jugar');
		Writeln('Presione 2 para ver el Registro de partidas');
		Writeln('Presione 3 para salir');
		Readln(opcion);
		case opcion of
			'1':Begin
					Writeln('usted ha elegido la opcion de jugar');
					Writeln('Elija la difilcutad que quiere jugar');
					Writeln('1. Facil');
					Writeln('2. Intermedio');
					writeln('3. Dificil');
					readln(difilcultad);
				End;
			'2':Begin
				Writeln('usted ha elegido la opcion de Registro');
				End;
			'3':Begin
				
				End;
			End;
	End;
	until (opcion='3');
END.

