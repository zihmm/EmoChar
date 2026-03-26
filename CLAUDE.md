# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

EmoChar is a macOS utility app that displays emojis and Unicode symbols (arrows, math, currency, misc) in a categorized, searchable grid. Clicking a symbol copies it to the clipboard.

## Tech Stack

- **Language**: Swift 5.9
- **UI**: SwiftUI (macOS 13+)
- **Project generation**: xcodegen (`project.yml` → `EmoChar.xcodeproj`)

## Commands

```bash
# Regenerate Xcode project after changing project.yml
xcodegen generate

# Build
xcodebuild -project EmoChar.xcodeproj -scheme EmoChar -configuration Debug build

# Open in Xcode
open EmoChar.xcodeproj
```

## Architecture

```
src/
├── EmoCharApp.swift          # @main entry, WindowGroup
├── ContentView.swift         # NavigationSplitView; owns search state + filtering logic
├── Models/Symbol.swift       # SymbolCategory enum, SymbolItem struct
├── Data/SymbolData.swift     # All hardcoded symbol arrays (emojis, arrows, math, misc)
└── Views/
    ├── SidebarView.swift     # Category list (List with selection binding)
    ├── SymbolGridView.swift  # LazyVGrid of cells; empty state
    └── SymbolCellView.swift  # Single cell: hover highlight, click-to-copy, "Copied!" feedback
```

**Data flow**: `ContentView` holds `selectedCategory` and `searchText`. `filteredSymbols` (computed) pulls from `SymbolData.symbols(for:)` and applies the search filter. The result is passed directly to `SymbolGridView`.

**Adding symbols**: add entries to the relevant static array in `src/Data/SymbolData.swift`. Adding a new category requires a new case in `SymbolCategory` plus a new array and `switch` branch in `SymbolData`.

**Clipboard copy** is done in `SymbolCellView` via `NSPasteboard.general`. The `"Copied!"` label replaces the symbol name for 1.2 seconds using a `@State` bool + `DispatchQueue.main.asyncAfter`.
