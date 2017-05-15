@echo on

set PROJECT_HOME=E:\eclipse_Workspace\RAP
cd /d %PROJECT_HOME%

rem 0) 打包ROOT.war,sleep 10s E:\eclipse_Workspace\RAP\target
start cmd /c "cd /d %PROJECT_HOME% && mvn package "
ping 127.0.0.1 -n 30

rem 1) stop tomcat8, sleep 2s
start cmd /c "cd /d %CATALINA_HOME%\bin && catalina.bat stop "
ping 127.0.0.1 -n 5

rem 2) delete all under ROOT, sleep 2s
del /f /q %CATALINA_HOME%\webapps\ROOT.war
rd /s /q %CATALINA_HOME%\webapps\ROOT
md %CATALINA_HOME%\webapps\ROOT
ping 127.0.0.1 -n 5

rem 3) start tomcat8, sleep 5s
start cmd /c "cd /d %CATALINA_HOME%\bin && catalina.bat start "
ping 127.0.0.1 -n 5

rem 4) copy new war to webapps, sleep 5s
echo f | xcopy /y /r %PROJECT_HOME%\target\RAP-1.0.war %CATALINA_HOME%\webapps\ROOT.war
ping 127.0.0.1 -n 30

rem 5) go back orig path
cd /d %PROJECT_HOME%
