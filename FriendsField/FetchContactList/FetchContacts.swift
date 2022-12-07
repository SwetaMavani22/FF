//
//  FetchContacts.swift
//  FriendsField
//
//  Created by iMac on 16/09/22.
//

import Foundation
import Contacts

struct FetchedContact {
    var firstName: String
    var lastName: String
    var telephone: String
}


class FetchContact {
    
    func fetchContacts(complation : @escaping ([FetchedContact]) -> ()) {
        // 1.
        var contacts = [FetchedContact]()

        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    // 3.
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        contacts.append(FetchedContact(firstName: contact.givenName, lastName: contact.familyName, telephone: contact.phoneNumbers.first?.value.stringValue ?? ""))
                    })
                    print(contacts)
                    complation(contacts)
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }   
        }
        complation ([FetchedContact]())
    }
}
