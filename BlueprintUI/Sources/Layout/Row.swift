import UIKit

/// Displays a list of items in a linear horizontal layout.
public struct Row: StackElement {

    public var children: [(element: Element, traits: StackLayout.Traits, key: AnyHashable?)] = []

    private (set) public var layout = StackLayout(axis: .horizontal)

    public init() {}

    public var horizontalUnderflow: StackLayout.UnderflowDistribution {
        get { return layout.underflow }
        set { layout.underflow = newValue }
    }

    public var horizontalOverflow: StackLayout.OverflowDistribution {
        get { return layout.overflow }
        set { layout.overflow = newValue }
    }

    public var verticalAlignment: StackLayout.Alignment {
        get { return layout.alignment }
        set { layout.alignment = newValue }
    }

    public var minimumHorizontalSpacing: CGFloat {
        get { return layout.minimumSpacing }
        set { layout.minimumSpacing = newValue }
    }

}

public struct StackChild: ProxyElement {

    public var elementRepresentation: Element {
        self.element
    }

    public var growsPriority: CGFloat = 1
    public var shrinkPriority: CGFloat = 1
    public var element: Element

}

extension Element {

    var growsPriority: CGFloat { 1 }
    var shrinkPriority: CGFloat { 1 }
    var element: Element { self }

}

public extension Element {

    func withGrowthPriority(_ p: CGFloat) -> StackChild {
        if var this = self as? StackChild {
            this.growsPriority = p
            return this
        } else {
            return StackChild(
                growsPriority: p,
                shrinkPriority: 1,
                element: self
            )
        }
    }

    func withShrinkPriority(_ p: CGFloat) -> StackChild {
        if var this = self as? StackChild {
            this.shrinkPriority = p
            return this
        } else {
            return StackChild(
                growsPriority: 1,
                shrinkPriority: p,
                element: self
            )
        }
    }

    func constrainedBy(
        width: ConstrainedSize.Constraint = .unconstrained,
        height: ConstrainedSize.Constraint = .unconstrained
    ) -> ConstrainedSize {
        return ConstrainedSize(
            width: width,
            height: height,
            wrapping: self)
    }

}

public extension Row {
    mutating func build(@RowBuilder _ items : () -> [Element])
    {
        self.children = items().map({
            return (
                element: $0.element,
                traits: StackLayout.Traits(
                    growPriority: $0.growsPriority,
                    shrinkPriority: $0.shrinkPriority
                ),
                key: nil)
        })
    }

    init(@RowBuilder _ items : () -> [Element]) {
        self = Row { row in
            row.build(items)
        }
    }
}

public extension Column {

    mutating func build(@RowBuilder _ items : () -> [Element])
    {
        self.children = items().map({
            return (
                element: $0.element,
                traits: StackLayout.Traits(
                    growPriority: $0.growsPriority,
                    shrinkPriority: $0.shrinkPriority
                ),
                key: nil)
        })
    }

    init(@RowBuilder _ items : () -> [Element]) {
        self = Column { column in
            column.build(items)
        }
    }
}

@_functionBuilder
public struct RowBuilder {
    public static func buildBlock(_ elements : Element?...) -> [Element] {

        return Array(elements.compactMap({$0}))

    }
}
