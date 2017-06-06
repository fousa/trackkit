//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

extension String {

    private static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "HHmmss"
        return formatter
    }

    var nmeaTimeValue: Date? {
        // Remove the `.` from the date string when set.
        let dateComponent = components(separatedBy: ".")
        guard
            let dateString = dateComponent.first,
            dateString != "" else { return nil }

        return String.timeFormatter.date(from: dateString)
    }

    var nmeaNavigationReceiverWarning: NavigationReceiverWarning? {
        return NavigationReceiverWarning(rawValue: self)
    }

    var nmeaGPSQuality: GPSQuality? {
        return GPSQuality(rawValue: self)
    }

    var integerValue: Int? {
        return Int(self)
    }

    var doubleValue: Double? {
        return Double(self)
    }

    var checksumEscapedString: String? {
        return components(separatedBy: "*").first
    }

}
