//
//  MainSceneViewModel.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 10.06.2021.
//

import Foundation
import Combine
//
//enum MainSceneError: LocalizedError {
//    case failedToLoadData
//    
//    var displayMessage: String {
//        switch self {
//        case .failedToLoadData:
//            return "Network error, try again later."
//        }
//    }
//}
//
//class MainSceneViewModel {
//    private var subscriptions = Set<AnyCancellable>()
//        
//    // MARK: Input
//    private var loadCategoriesData = PassthroughSubject<Void, Never>().eraseToAnyPublisher()
//    private var loadInfoData = PassthroughSubject<Int, Never>().eraseToAnyPublisher()
//
//
//    // MARK: Display data
//    @Published var categories = [CategoryViewModel]()
//    @Published var details = [DetailsViewModel]()
//
//    func attachViewEventListener(loadCategoriesData: AnyPublisher<Void, Never>) {
//        self.loadCategoriesData = loadCategoriesData
//        loadCategoriesData
//            .setFailureType(to: StarWarsAPIError.self)
//            .flatMap { _ -> AnyPublisher<[Category], StarWarsAPIError> in
//                let service = NetworkService()
//                return  //service.loadCategories()
//            }
//            .map { self.categoryViewModels(from: $0) }
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion:{ [weak self] completion in
//                
//                switch completion {
//                case .finished:
//                    print("Done!")
//                default: break //$categories.
////                    self?.reloadCategoriesSubject.send(completion: .failure(.failedToLoadData))
//                }
//                
//            }, receiveValue: { [weak self] categories in
//                self?.categories = categories
//            })
//            .store(in: &subscriptions)        
//    }
//    
//    func attachViewEventListener(loadDetailsData: AnyPublisher<Int, Never>) {
//        self.loadInfoData = loadDetailsData
//        loadDetailsData
//            .setFailureType(to: StarWarsAPIError.self)
//            .delay(for: 0, scheduler: RunLoop.main)
//            .compactMap { self.categories[$0].url }
//            .flatMap { url -> AnyPublisher<[DetailType], StarWarsAPIError> in
//                let service = NetworkService()
//                switch url.dataType {
//                case .film:
//                    return service.loadFilms(with: url)
//                case .unknown:
//                    return Fail(error: StarWarsAPIError.invalidURL).eraseToAnyPublisher()
//                }
//            }
//            .map { self.detailViewModels(from: $0) }
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion:{ _ in },
//                  receiveValue: { [weak self] details in
//                    self?.details = details
//            })
//            .store(in: &subscriptions)
//    }
//    
//    private func categoryViewModels(from categories: [Category]) -> [CategoryViewModel] {
//        return categories.compactMap { CategoryViewModel($0) }
//    }
//    
//    private func detailViewModels(from details: [DetailType]) -> [DetailsViewModel] {
//        return details.compactMap { ViewModelBuilder.viewModel(from: $0) }
//    }
//}
