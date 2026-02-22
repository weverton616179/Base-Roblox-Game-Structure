-- these can be ignored if you are using the studio plugin
option ClientOutput = "../archives/teste/client.luau"
option ServerOutput = "../archives/teste/server.luau"
 
event MyFirstEvent {
    from: Server,
    type: Reliable,
    call: SingleSync,
    data: (string, u8)
}

event eventoTeste {
    from: Client,
    type: Reliable,
    call: SingleSync,
    data: (string, u8)
}