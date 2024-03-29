//
//  CodableExtension.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation

extension Encodable {
  func asDictionary()  -> [String: Any]? {
    let data = try? JSONEncoder().encode(self)
      if(data == nil) {
          return nil
      }
    guard let dictionary = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {
      return nil
    }
    return dictionary
  }
}
