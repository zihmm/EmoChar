import SwiftUI
import AppKit

struct SymbolCellView: View {
    let symbol: SymbolItem
    @State private var isHovered = false
    @State private var showCopied = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(isHovered ? Color.accentColor.opacity(0.15) : Color.clear)

            VStack(spacing: 2) {
                Text(symbol.char)
                    .font(.system(size: 28))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)

                Text(showCopied ? "Copied!" : symbol.name)
                    .font(.system(size: 9, weight: showCopied ? .medium : .regular))
                    .foregroundStyle(showCopied ? Color.green : Color.secondary)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .animation(.easeInOut(duration: 0.15), value: showCopied)
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 6)
        }
        .frame(width: 76, height: 66)
        .help(symbol.name)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.1)) {
                isHovered = hovering
            }
            if hovering {
                NSCursor.pointingHand.set()
            } else {
                NSCursor.arrow.set()
            }
        }
        .onTapGesture {
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(symbol.char, forType: .string)
            showCopied = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                showCopied = false
            }
        }
    }
}
