*** Settings ***
Library             RequestsLibrary
Library             Collections
Library             String
Library             OperatingSystem
Library             JSONLibrary

*** Variables ***

${API_PROVA}     https://gorest.co.in
${TOKEN}         2fa57af4dd015378f4caec1b108aae04287884c2c15c665573b1a51d7ff7d235
${json_object}
${ID_USUARIO}

*** Test Cases ***

Login
    Login url

Criar Usuario
    Criacao Usuario
    
Consultar Usuario Criado
    Consulta Usuario

Update Usuario
    Update Nome Usuario

Deletar Usuario
    Delete Usuario Criado

*** Keywords ***

Login url
    ${HEADERS}
    ...     Create Dictionary
    ...     Authorization=Bearer ${TOKEN}
    Create Session
    ...     alias=urlapi
    ...     url=${API_PROVA}
    ...     headers=${HEADERS}
    ...     disable_warnings=True

Criacao Usuario
    ${BODY}
    ...     Create Dictionary
    ...     name=Shuna
    ...     email=superemail@weimann.net
    ...     gender=male
    ...     status=inactive
    ${RESPONSE}
    ...     Post Request
    ...     alias=urlapi
    ...     uri=/public/v2/users
    ...     data=${BODY}
    ${json_object}=
    ...     To Json
    ...     ${RESPONSE.content}
    Set Global Variable
    ...     ${ID_USUARIO}
    ...     ${json_object["id"]}
    Confere sucesso na requisição
    ...     ${RESPONSE}

Consulta Usuario    
    ${CONSULTA_USU}   
    ...     Get Request
    ...     alias=urlapi
    ...     uri=/public/v2/users/${ID_USUARIO}
    Confere sucesso na requisição
    ...     ${CONSULTA_USU}

Update Nome Usuario
    ${UPDATE}   
    ...     Create Dictionary
    ...     name=Kyrion
    ${UPDATE_NOME}
    ...     Put Request
    ...     alias=urlapi
    ...     uri=/public/v2/users/${ID_USUARIO}
    ...     data=${UPDATE}    
    Confere sucesso na requisição   
    ...     ${UPDATE_NOME}

Delete Usuario Criado
    ${DELETE_USUARIO}   
    ...     Delete Request
    ...     alias=urlapi
    ...     uri=/public/v2/users/${ID_USUARIO}
    Confere sucesso na requisição   
    ...     ${DELETE_USUARIO}

Confere sucesso na requisição
    [Arguments]      
    ...     ${RESPONSE}
    Should Be True   '${RESPONSE.status_code}'=='200' or '${RESPONSE.status_code}'=='201' or '${RESPONSE.status_code}'=='204'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}