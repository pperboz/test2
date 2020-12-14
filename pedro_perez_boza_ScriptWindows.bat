
ECHO OFF
CLS
:MENU
CLS
TITLE Script Pedro PB
ECHO.
ECHO ...............................................
ECHO Selecciona el comando a ejecutar
ECHO ...............................................
ECHO.
ECHO 1 - Nuevo Usuario
ECHO 2 - Nuevo Grupo
ECHO 3 - Nueva Unidad Organizativa
ECHO 4 - Mover Usuario a Grupo
ECHO 5 - Eliminar Usuario
ECHO 6 - Listar Grupos y Usuarios
ECHO 7 - SALIR
ECHO.
SET /P M=Selecciona y pulsa ENTER:
IF %M%==1 GOTO NewUser
IF %M%==2 GOTO NewGroup
IF %M%==3 GOTO NewOU
IF %M%==4 GOTO AddUserToGroup
IF %M%==5 GOTO DelUser
IF %M%==6 GOTO ListGroups
IF %M%==7 GOTO EOF

	:NewUser
		title NUEVO USUARIO
		echo.
		SET /P USER= Nombre del nuevo usuario:
		echo.
		dsadd user cn=%USER%,cn=Users,dc=ppb,dc=local 
		echo.
		PAUSE
		GOTO MENU
	:NewGroup
		title NUEVO GRUPO
		echo.
		SET /P GROUP= Nombre del Nuevo Grupo:
		echo.
		dsadd GROUP cn=%group%,cn=Users,dc=ppb,dc=local
		echo.
		PAUSE
		GOTO MENU
	:NewOU
		title NUEVA UNIDAD ORGANIZATIVA
		echo.
		SET /P Unidad= Nombre de Nueva Unidad Organizativa:
		echo.
		dsadd ou ou=%unidad%,dc=ppb,dc=local
		echo.
		PAUSE
		GOTO MENU
		
	:AddUserToGroup
		TITLE AÑADIR USUARIO A GRUPO
		cls
		echo Usuarios creados en el dominio
		ECHO.
		dsquery user
		ECHO.
		SET /P User2= Escriba el CN del usuario:
		CLS
		echo Grupos en el dominio
		echo.
		dsquery group
		echo.
		SET /P Group2= Escriba el CN del grupo:
		ECHO.
		dsmod group "CN=%Group2%,CN=Users,DC=PPB,DC=local" -addmbr "CN=%User2%,CN=Users,DC=PPB,DC=local"
		echo.
		pause		
		CLS
		echo Usuarios en el Grupo: %Group2%
		echo.
		dsget group "CN=%Group2%,CN=Users,DC=PPB,DC=local" -members
		echo.
		pause
		GOTO MENU
	
	:DelUser
		TITLE ELIMINAR USUARIO
		cls
		echo Usuarios creados en el dominio
		ECHO.
		dsquery user 
		ECHO.
		SET /P User3= Escriba el CN del usuario a borrar:
		ECHO.
		DSRM "CN=%User3%,CN=Users,DC=PPB,DC=local"
		pause
		GOTO MENU
	
	:ListGroups
		TITLE LISTAR GRUPOS Y USUARIOS
		cls
		dsquery group > temp.txt
		FOR /f "tokens=*" %%a IN (temp.txt) DO (
			echo GRUPO ************ %%a ************  
			echo MIEMBROS: 
			dsget group %%a -members
			echo.)
		del temp.txt
		pause
		GOTO MENU
	