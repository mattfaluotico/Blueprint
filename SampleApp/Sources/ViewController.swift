import UIKit
import BlueprintUI
import BlueprintUICommonControls


struct Post {
    var authorName: String
    var timeAgo: String
    var body: String
}

let posts = [
    Post(
        authorName: "Tim",
        timeAgo: "1 hour ago",
        body: "Lorem Ipsum"),
    Post(
        authorName: "Jane",
        timeAgo: "2 days ago",
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
    Post(
        authorName: "John",
        timeAgo: "2 days ago",
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit!")

]


final class ViewController: UIViewController {

    private let blueprintView = BlueprintView(element: List(posts: posts))

    override func loadView() {
        self.view = blueprintView
    }

}


fileprivate struct List: ProxyElement {

    var posts: [Post]

    var elementRepresentation: Element {
        let col = Column { col in
            col.horizontalAlignment = .fill
            col.minimumVerticalSpacing = 8.0

            for post in posts {
                col.add(child: FeedItem(post: post))
            }
        }

        var scroll = ScrollView(wrapping: col)
        scroll.contentSize = .fittingHeight
        scroll.alwaysBounceVertical = true

        let background = Box(
            backgroundColor: UIColor(white: 0.95, alpha: 1.0),
            wrapping: scroll)

        return background
    }

}


fileprivate struct FeedItem: ProxyElement {

    var post: Post

    var elementRepresentation: Element {
        let element = Row { row in
            row.verticalAlignment = .leading
            row.minimumHorizontalSpacing = 16.0
            row.horizontalUnderflow = .growUniformly

            let avatar = ConstrainedSize(
                width: .absolute(64),
                height: .absolute(64),
                wrapping: Box(
                    backgroundColor: .lightGray,
                    cornerStyle: .rounded(radius: 32.0),
                    wrapping: nil))

            row.add(
                growPriority: 0.0,
                shrinkPriority: 0.0,
                child: avatar)

            row.add(
                growPriority: 1.0,
                shrinkPriority: 1.0,
                child: FeedItemBody(post: post))
        }

        let box = Box(
            backgroundColor: .white,
            wrapping: Inset(
                uniformInset: 16.0,
                wrapping: element))


        return box
    }

}

fileprivate struct FeedItemBody: ProxyElement {

    var post: Post

    var elementRepresentation: Element {
        let column = Column { col in

            col.horizontalAlignment = .leading
            col.minimumVerticalSpacing = 8.0

            let header = Row { row in
                row.minimumHorizontalSpacing = 8.0
                row.verticalAlignment = .center

                var name = Label(text: post.authorName)
                name.font = UIFont.boldSystemFont(ofSize: 14.0)
                row.add(child: name)

                var timeAgo = Label(text: post.timeAgo)
                timeAgo.font = UIFont.systemFont(ofSize: 14.0)
                timeAgo.color = .lightGray
                row.add(child: timeAgo)
            }

            col.add(child: header)

            var body = Label(text: post.body)
            body.font = UIFont.systemFont(ofSize: 13.0)

            col.add(child: body)
        }

        return column
    }

}
