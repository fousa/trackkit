//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 21/03/16.
//

extension String {

    func isoDate() -> Date? {
        return DateFormatter.isoDateFormatter.date(from: self)
    }

    func isoDateWithMilliseconds() -> Date? {
        return DateFormatter.isoDateFormatterWithMilliseconds.date(from: self)
    }

}

extension DateFormatter {

    fileprivate static let isoDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()

    fileprivate static let isoDateFormatterWithMilliseconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()

}
