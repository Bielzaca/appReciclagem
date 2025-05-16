1 - Importar o arquivo bancoreciclagemv2_10.sql no workbench

2 - Instalar o JDK Versão 21 ou superior

3 - Instalar o IntelliJ ou outra IDE com suporte para o Maven

4 - Mudar o arquivo application.properties em /src/main/resources/ para as credenciais do seu banco

EX:

spring.datasource.url=jdbc:mysql://localhost:3306/NomeDoBanco?useSSL=false&serverTimezone=UTC
spring.datasource.username=SeuUsuario
spring.datasource.password=SuaSenha

5 - Rodar o arquivo principal AppReciclagemApplication.java localizado em /src/main/java/br/AppReciclagem/appReciclagem/

6 - Acessar no navegador o servidor local, geralmente é localhost:8080/ se voce nao mudou nada além das credenciais do banco no application.properties
