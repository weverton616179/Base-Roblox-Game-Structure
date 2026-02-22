-- these can be ignored if you are using the studio plugin
option ClientOutput = "../archives/coin/client.luau"
option ServerOutput = "../archives/coin/server.luau"
 
event UpdateCoins {
    from: Server,
    type: Reliable,
    call: SingleAsync,
    data: u32
}

event RequestCoins {
    from: Client,
    type: Reliable,
    call: SingleAsync,
    data: ()
}