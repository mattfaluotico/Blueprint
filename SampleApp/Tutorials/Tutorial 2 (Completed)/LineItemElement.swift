import BlueprintUI
import BlueprintUICommonControls

struct LineItemElement: ProxyElement {

    var style: Style
    var title: String
    var price: Double

    var elementRepresentation: Element {
        return Row({

            Label(
                text: title,
                configure: {
                    $0.font = style.titleFont
                    $0.color = style.titleColor
                })

            Column({
                Label(text: "one")
                    .withGrowthPriority(0)
                Label(text: "two")
            })

            Label(
                text: {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .currency
                    return formatter.string(from: NSNumber(value: price)) ?? ""
                }(),
                configure: {
                    $0.font = style.priceFont
                    $0.color = style.priceColor
                })
                .withGrowthPriority(0)
                .withShrinkPriority(0)
                .constrainedBy(
                    width: .absolute(140),
                    height: .absolute(140)
                )

            (price >= 10_00)
                ? Label(text: "It's expensive!")
                    .withShrinkPriority(0)
                    .withGrowthPriority(0)
                : nil

        })
    }

}

extension LineItemElement {

    enum Style {
        case regular
        case bold

        fileprivate var titleFont: UIFont {
            switch self {
            case .regular: return .systemFont(ofSize: 18.0)
            case .bold: return .boldSystemFont(ofSize: 18.0)
            }
        }

        fileprivate var titleColor: UIColor {
            switch self {
            case .regular: return .gray
            case .bold: return .black
            }
        }

        fileprivate var priceFont: UIFont {
            switch self {
            case .regular: return .systemFont(ofSize: 18.0)
            case .bold: return .boldSystemFont(ofSize: 18.0)
            }
        }

        fileprivate var priceColor: UIColor {
            switch self {
            case .regular: return .black
            case .bold: return .black
            }
        }

    }

}
