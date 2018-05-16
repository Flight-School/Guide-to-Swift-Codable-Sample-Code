import Foundation

let json = """
{
    "title": "Sint Pariatur Enim ut Lorem Eiusmod",
    "body": "Cillum deserunt ullamco minim nulla et nulla ea ex eiusmod ea exercitation qui irure irure. Ut laboris amet Lorem deserunt consequat irure dolore quis elit eiusmod. Dolore duis velit consequat dolore. Qui aliquip ad id eiusmod in do officia. Non fugiat esse laborum enim pariatur cillum. Minim aliquip minim exercitation anim adipisicing amet. Culpa proident adipisicing labore enim ullamco veniam.",
    "metadata": {
        "key": "value"
    }
}
""".data(using: .utf8)!

let decoder = JSONDecoder()
let report = try decoder.decode(Report.self, from: json)

print(report.title)
print(report.body)
print(report.metadata["key"])
