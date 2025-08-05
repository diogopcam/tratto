//
//  TaskCategory.swift
//  Tasks
//
//  Created by Igor Vicente on 30/07/25.
//
import Foundation

enum TaskCategory: String, CaseIterable, Identifiable {    
    case education = "Education"
    case fitness = "Fitness"
    case groceries = "Groceries"
    case health = "Health"
    case home = "Home"
    case personal = "Personal"
    case reading = "Reading"
    case shopping = "Shopping"
    case travel = "Travel"
    
    var id: String { rawValue }
    
    var imageName: String {
        switch self {
        case .education:
            return "graduationcap.fill"
        case .fitness:
            return "dumbbell.fill"
        case .groceries:
            return "fork.knife"
        case .health:
            return "pills.fill"
        case .home:
            return "house.fill"
        case .personal:
            return "person.fill"
        case .reading:
            return "book.fill"
        case .shopping:
            return "cart.fill"
        case .travel:
            return "airplane"
        }
    }
}
