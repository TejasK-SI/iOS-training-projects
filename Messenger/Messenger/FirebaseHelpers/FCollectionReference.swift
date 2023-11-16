//
//  FCollectionReference.swift
//  Messenger
//
//  Created by Tejas Kashid on 04/10/23.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference : String {
    case User
    case Recent
    case Messages
    case Typing
    case Channel
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
