//
//  NetworkError.swift
//  Airbnb
//
//  Created by delma on 2020/06/04.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case InvalidURL
    case DecodeError
    case EncodeError
    case BadRequest
    
    var description: String {
        switch self {
        case .InvalidURL:
            return "유효하지 않은 URL입니다"
        case .DecodeError:
            return "올바른 Decode 형식이 아닙니다"
        case .EncodeError:
            return "올바른 Encode 형식이 아닙니다"
        case .BadRequest:
            return "잘못된 요청입니다"
        }
    }
}
