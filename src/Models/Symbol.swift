import Foundation

// Top-level sidebar items
enum SidebarItem: String, CaseIterable, Identifiable, Hashable {
    case emojis = "Emojis"
    case arrows = "Arrows"
    case math   = "Math"
    case misc   = "Misc"

    var id: String { rawValue }

    var systemImage: String {
        switch self {
        case .emojis: return "face.smiling"
        case .arrows: return "arrow.right"
        case .math:   return "function"
        case .misc:   return "star"
        }
    }
}

// All data categories — emoji sub-categories + Unicode symbol categories
enum SymbolCategory: String, CaseIterable, Identifiable, Hashable {
    // Emoji sub-categories (shown in the in-content segmented control)
    case people  = "People"
    case nature  = "Nature"
    case objects = "Objects"
    case places  = "Places"
    case symbols = "Symbols"
    // Unicode symbol categories (each a top-level sidebar item)
    case arrows  = "Arrows & Geometric"
    case math    = "Math & Currency"
    case misc    = "Misc Symbols"

    var id: String { rawValue }

    // The five emoji sub-categories in display order
    static let emojiCategories: [SymbolCategory] = [.people, .nature, .objects, .places, .symbols]

    var systemImage: String {
        switch self {
        case .people:  return "person.2"
        case .nature:  return "leaf"
        case .objects: return "archivebox"
        case .places:  return "map"
        case .symbols: return "number"
        case .arrows:  return "arrow.right"
        case .math:    return "function"
        case .misc:    return "star"
        }
    }
}

struct SymbolItem: Identifiable {
    let id = UUID()
    let char: String
    let name: String
    let category: SymbolCategory
}
