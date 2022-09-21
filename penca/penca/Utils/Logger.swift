//
//  Logger.swift
//  penca
//
//  Created by Lucas Bloise on 21/09/2022.
//

import Foundation

struct Logger {
    
    #if DEBUG
    static let enabled: [LogLevel] = [
        .verbose,
        .network,
        .info,
        .debug,
        .error,
    ]
    #else
    static let enabled: [LogLevel] = []
    #endif
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    static func log(_ values: Any?..., level: LogLevel = .verbose, function: String = #function, line: String = String(#line)) {
        guard enabled.contains(level) else { return }
        values.forEach { (value) in
            print("\(formatter.string(from: Date())) \(function) | \(level.title) \(value == nil ? "nil" : String(describing: value!))")
        }
    }
}

extension Logger {
    enum LogLevel {
        case verbose, network, info, debug, error
        
        var title: String {
            switch self {
            case .verbose: return "💬 VERBOSE:"
            case .network: return "🌐 NETWORK:"
            case .info: return "ℹ️ INFO:"
            case .debug: return "⚠️ DEBUG:"
            case .error: return "❗️ ERROR:"
            }
        }
    }
}

