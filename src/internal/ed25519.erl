-module(ed25519).
-export([verify_message/3]).

verify_message(Message, Signature, PublicKey) ->
    crypto:verify(eddsa, none, Message, Signature, [PublicKey, ed25519]).
