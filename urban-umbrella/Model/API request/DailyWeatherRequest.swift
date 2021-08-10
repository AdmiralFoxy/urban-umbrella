//
//  DailyWeatherRequest.swift
//  urban-umbrella
//
//  Created by Stanislav on 08.08.2021.
//

import Foundation
import Combine

protocol WeatherFetchable {
    func severalDaysWeatherForecast(
        forCity city: String
    ) -> AnyPublisher<SeveralDaysWeather, WeatherError>
}

class WeatherFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension WeatherFetcher: WeatherFetchable {
    func severalDaysWeatherForecast(
        forCity city: String
    ) -> AnyPublisher<SeveralDaysWeather, WeatherError> {
        return forecast(with: makeWeeklyForecastComponents(withCity: city))
    }
    
    private func forecast<T>(
        with components: URLComponents
    ) -> AnyPublisher<T, WeatherError> where T: Decodable {
        guard let url = components.url else {
            let error = WeatherError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}

private extension WeatherFetcher {
    func makeWeeklyForecastComponents(
        withCity city: String
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = APIConstants.scheme.rawValue
        components.host = APIConstants.host.rawValue
        components.path = APIConstants.path.rawValue + APIConstants.forecast.rawValue
        
        components.queryItems = [
            URLQueryItem(name: APIConstants.qValue.rawValue, value: city),
            URLQueryItem(name: APIConstants.mode.rawValue, value: APIConstants.valueJson.rawValue),
            URLQueryItem(name: APIConstants.modeUnits.rawValue, value: APIConstants.valueMetric.rawValue),
            URLQueryItem(name: APIConstants.appid.rawValue, value: APIConstants.key.rawValue)
        ]
        print(components)
        return components
    }
}

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, WeatherError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}
