//
//  Detailswift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation

protocol Detailable: Decodable {
    var imagePath: String { get }
    var name: String { get }
}

struct DefaultDetail: Detailable {
    var imagePath: String { name } // FIXME: 
    var name: String
}
