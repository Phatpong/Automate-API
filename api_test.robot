*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Test Cases ***
GET - All Users
    Create Session    reqres    https://reqres.in/api
    ${response}    GET On Session    reqres    /users
    Should Be Equal As Strings    ${response.status_code}    200
    ${ArrayStorage}    Create List
    FOR    ${user}    IN    @{response.json()['data']}
        Append To List    ${ArrayStorage}    ${user}
    END
    Log    ${ArrayStorage}

GET - User Info
    Create Session    reqres    https://reqres.in/api
    ${response}    GET On Session    reqres    /users/1
    Should Be Equal As Strings    ${response.status_code}    200
    ${Objects}    Set Variable    ${response.json()['data']}
    Log    ${Objects}

POST - Create User
    Create Session    reqres    https://reqres.in/api
    ${headers}    Create Dictionary    Content-Type=application/json
    ${payload}    Create Dictionary    email= "pongpong@hotmail.com"    first_name="pong"    last_name="zaza"    avatar="https://reqres.in/img/faces/1-image.jpg"
    ${response}    POST On Session    reqres    /users    json=${payload}    headers=${headers}
    Log    ${headers}
    Log    ${payload}

Patch - Update User
    Create Session    reqres    https://reqres.in/api    
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary    email=pongpong@hotmail.com
    ${response}=    PATCH On Session    reqres    /users/1    json=${payload}    headers=${headers}
    Status Should Be    200    ${response}
    ${resp_json}=    Set Variable    ${response.json()}
    Log    Response: ${resp_json}     

Delete - Delete User
    Create Session    reqres    https://reqres.in/api
    ${response}=    DELETE On Session    reqres    /users/1
    Status Should Be    204    ${response}
    