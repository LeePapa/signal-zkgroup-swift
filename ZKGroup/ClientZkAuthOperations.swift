// Generated by zkgroup/codegen/codegen.py - do not edit

import Foundation
import libzkgroup

public class ClientZkAuthOperations {

  let serverPublicParams: ServerPublicParams

  public init(serverPublicParams: ServerPublicParams) {
    self.serverPublicParams = serverPublicParams
  }

  public func receiveAuthCredential(uuid: ZKGUuid, redemptionTime: UInt32, authCredentialResponse: AuthCredentialResponse) throws  -> AuthCredential {
    var newContents: [UInt8] = Array(repeating: 0, count: AuthCredential.SIZE)

    let ffi_return = FFI_ServerPublicParams_receiveAuthCredential(serverPublicParams.getInternalContentsForFFI(), UInt64(serverPublicParams.getInternalContentsForFFI().count), uuid.getInternalContentsForFFI(), UInt64(uuid.getInternalContentsForFFI().count), redemptionTime, authCredentialResponse.getInternalContentsForFFI(), UInt64(authCredentialResponse.getInternalContentsForFFI().count), &newContents, UInt64(newContents.count))
    if (ffi_return == Native.FFI_RETURN_INPUT_ERROR) {
      throw ZkGroupException.VerificationFailed
    }

    if (ffi_return != Native.FFI_RETURN_OK) {
      throw ZkGroupException.ZkGroupError
    }

    do {
      return try AuthCredential(contents: newContents)
    } catch ZkGroupException.InvalidInput {
      throw ZkGroupException.AssertionError
    }

  }

  public func createAuthCredentialPresentation(groupSecretParams: GroupSecretParams, authCredential: AuthCredential) throws  -> AuthCredentialPresentation {
    var randomness: [UInt8] = Array(repeating: 0, count: Int(32))
    let result = SecRandomCopyBytes(kSecRandomDefault, randomness.count, &randomness)
    guard result == errSecSuccess else {
      throw ZkGroupException.AssertionError
    }

    return try createAuthCredentialPresentation(randomness: randomness, groupSecretParams: groupSecretParams, authCredential: authCredential)
  }

  public func createAuthCredentialPresentation(randomness: [UInt8], groupSecretParams: GroupSecretParams, authCredential: AuthCredential) throws  -> AuthCredentialPresentation {
    var newContents: [UInt8] = Array(repeating: 0, count: AuthCredentialPresentation.SIZE)

    let ffi_return = FFI_ServerPublicParams_createAuthCredentialPresentationDeterministic(serverPublicParams.getInternalContentsForFFI(), UInt64(serverPublicParams.getInternalContentsForFFI().count), randomness, UInt64(randomness.count), groupSecretParams.getInternalContentsForFFI(), UInt64(groupSecretParams.getInternalContentsForFFI().count), authCredential.getInternalContentsForFFI(), UInt64(authCredential.getInternalContentsForFFI().count), &newContents, UInt64(newContents.count))

    if (ffi_return != Native.FFI_RETURN_OK) {
      throw ZkGroupException.ZkGroupError
    }

    do {
      return try AuthCredentialPresentation(contents: newContents)
    } catch ZkGroupException.InvalidInput {
      throw ZkGroupException.AssertionError
    }

  }

}
