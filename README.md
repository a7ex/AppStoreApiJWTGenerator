# AppStoreApiJWTGenerator
Generate Token for App Store Connect API Requests

## About
In order to use the [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi) you need to generate a JWT token.
The docs explain how the token shall be generated in [Generating Tokens for API Requests](https://developer.apple.com/documentation/appstoreconnectapi/generating_tokens_for_api_requests).

However, the actual command to create such a token in the end is missing. Instead the docs state something like go to jwt.io and there are tools to generate JWT tokens. There I found a library from IBM written in Swift.

So I went ahead and created this simple command line tool to generate JWT tokens suitable for the App Store Connect API.
The rest was a bit try and error and checking out the brandnew ArgumentParser library :-)

## Usage
```
astokengenerator --key-id <key-id> --issuer-id <issuer-id> --path-to-private-key <path-to-private-key>
```

 - **key-id** = Your private key ID from App Store Connect (Ex: 2X9R4HXF34)                              |
 - **issuer-id** = Your issuer ID from the API Keys page in App Store Connect (Ex: 57246542-96fe-1a63-e053-0824d011072a) |
 - **path-to-private-key** = The path to the private key in .p8 format                                                |

## Dependencies
- [SwiftJWT](https://github.com/IBM-Swift/Swift-JWT)
- [ArgumentParser](https://github.com/apple/swift-argument-parser)
