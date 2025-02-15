import gleam/bit_array
import gleam/bool
import gleam/result

pub type VerifyError {
  BadPublicKey
  BadSignature
}

@external(erlang, "ed25519", "verify_message")
fn verify_message(
  msg message: BitArray,
  sig signature: BitArray,
  key public_key: BitArray,
) -> Bool

pub fn verify(
  msg message: String,
  sig signature: String,
  key public_key: String,
) -> Result(Bool, VerifyError) {
  use public_key <- result.try(
    bit_array.base16_decode(public_key)
    |> result.replace_error(BadPublicKey),
  )
  use <- bool.guard(
    when: bit_array.byte_size(public_key) != 32,
    return: Error(BadPublicKey),
  )

  use signature <- result.try(
    bit_array.base16_decode(signature)
    |> result.replace_error(BadSignature),
  )
  use <- bool.guard(
    when: bit_array.byte_size(signature) != 64,
    return: Error(BadSignature),
  )

  let message = bit_array.from_string(message)

  Ok(verify_message(msg: message, sig: signature, key: public_key))
}
