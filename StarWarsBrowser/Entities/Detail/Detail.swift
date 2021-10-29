//
//  Detailswift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation

protocol Detail: Decodable {
    var type: Category.T { get }
    var imagePath: String { get }
}
