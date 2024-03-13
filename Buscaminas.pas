
program untitled;


var 
opcion, difilcultad: char;
decision: string;

BEGIN
	
	Repeat
	Begin
		Repeat
		Begin
			writeln('Bienvenido al juego de Buscaminas');
			Writeln('Presione 1 para Jugar');
			Writeln('Presione 2 para salir');
			Readln(opcion);
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
				End;
				until (difilcultad>'1') or (difilcultad<'4');//evita que se elija una difilcultad que no existe, pero te devuelve al inicio del programa
				case difilcultad of
					'1': begin
						Writeln('usted ha elegido la difilcultad facil');
						writeln('Diviertase');
						repeat
							Begin
								writeln('Ha terminado la partida');
								writeln('quiere reiniciar la partida?');
								writeln('o quiere volver a la pantalla de inicio');
								readln(decision);
							End;
						until (decision='pantalla de inicio');//para que el usuario decida si quiere volver a jugar o quiere reiniciar el programa
					End;
					'2': begin
						Writeln('usted ha elegido la difilcultad media');
						writeln('Diviertase');
						repeat
							Begin
								writeln('Ha terminado la partida');
								writeln('quiere reiniciar la partida?');
								writeln('o quiere volver a la pantalla de inicio');
								readln(decision);
							End;
						until (decision='pantalla de inicio');//para que el usuario decida si quiere volver a jugar o quiere reiniciar el programa
					End;
					'3': begin
							Writeln('usted ha elegido la difilcultad dificil');
							writeln('Diviertase');
							repeat
							Begin
								writeln('Ha terminado la partida');
								writeln('quiere reiniciar la partida?');
								writeln('quiere volver a la pantalla de inicio');
								readln(decision);
							End;
						until (decision='pantalla de inicio')//para que el usuario decida si quiere volver a jugar o quiere reiniciar el programa 
					End;
				End;
			End;
			
	End;
	until (opcion='3');
END.

