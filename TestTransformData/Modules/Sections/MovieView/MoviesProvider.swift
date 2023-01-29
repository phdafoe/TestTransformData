//  MoviesProvider.swift
//  Architecture VIP+UI
//
// This source file is open source project in iOS
// See README.md for more information

import Foundation
import Combine

// Input Protocol
protocol MoviesProviderInputProtocol: BaseProviderInputProtocol  {
    func fetchDataFromWeb(_ completion : @escaping (MoviesEntity) -> (), failure : @escaping(NetworkError) -> ())
}

class MoviesProvider: BaseProvider {
    
    // MARK: - DI
    weak var interactor: MoviesProviderOutputProtocol? {
        super.baseInteractor as? MoviesProviderOutputProtocol
    }
    
    let networkService: NetworkServiceInputProtocol = NetworkService()
    var cancellable: Set<AnyCancellable> = []
    
    
    
}

// Input Protocol
extension MoviesProvider: MoviesProviderInputProtocol {
    
    func fetchDataFromWeb(_ completion: @escaping (MoviesEntity) -> (), failure: @escaping (NetworkError) -> ()) {
        self.networkService.requestGeneric(payloadRequest: MoviesRequestDTO.requestData(movieId: "", supportParameters: ""),
                                           entityClass: MoviesEntity.self)
        .sink { [weak self] completion in
            guard self != nil else { return }
            switch completion{
            case .finished:
                debugPrint("finished")
            case let .failure(error):
                debugPrint(error)
                //self?.interactor?.setInformationFavourites(completion: .failure(error))
            }
        } receiveValue: { [weak self] resultData in
            guard self != nil else { return }
            debugPrint(resultData)
            //self?.interactor?.setInformationFavourites(completion: .success(resultData))
        }
        .store(in: &self.cancellable)
    }
}

// MARK: - Request de apoyo
struct MoviesRequestDTO {
    
    static func requestData(movieId: String, supportParameters: String) -> RequestDTO {
        let argument: [CVarArg] = [movieId, supportParameters]
        let urlComplete = String(format: URLEnpoint.endpointDetailMovie, arguments: argument)
        let request = RequestDTO(params: nil, method: .get, endpoint: urlComplete, urlContext: .webService)
        return request
    }
}
