//
//  main.swift
//  AppStoreApiJWTGenerator
//
//  Created by Alex da Franca on 05.04.20.
//  Copyright © 2020 Farbflash. All rights reserved.
//

import Foundation
import SwiftJWT
import ArgumentParser

struct AppStoreApiJWTGenerator: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "JWT Generator for AppStore API.")
    
    @Option(name: [.short, .customLong("key-id")], help: "The id of the private key (Find in AppStore Connect -> Users -> Keys)")
    var keyId: String
    
    @Option(name: [.short, .customLong("issuer-id")], help: "The issuer id (Find in AppStore Connect -> Users -> Keys)")
    var issuerID: String

    @Option(name: [.short, .customLong("path-to-private-key")], help: "The path to the private key file (that's the one you downloaded from AppStore Connect with the .p8 extension).")
    var privateKeyPath: String

    
    func run() throws {
        
        let myHeader = Header(kid: keyId)
        
        struct MyClaims: Claims {
            let iss: String
            let exp: Int
            let aud: String
        }
        let intDate = Int(Date(timeIntervalSinceNow: 1200).timeIntervalSince1970)
        let myClaims = MyClaims(iss: issuerID, exp: intDate, aud: "appstoreconnect-v1")
        
        var myJWT = JWT(header: myHeader, claims: myClaims)
        let privateKeyUrl = URL(fileURLWithPath: privateKeyPath)
        
        guard let privateKeyData = try? Data(contentsOf: privateKeyUrl) else {
            throw RuntimeError("Private key not found at path \(privateKeyPath)")
        }
        let signedJWT = try myJWT.sign(using: .es256(privateKey: privateKeyData))
        print("\(signedJWT)")
    }
}

struct RuntimeError: Error, CustomStringConvertible {
    var description: String
    
    init(_ description: String) {
        self.description = description
    }
}

AppStoreApiJWTGenerator.main()


