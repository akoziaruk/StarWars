//
//  MainUseCase.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 03.04.2022.
//

import UIKit
import Combine

final class DetailsUseCase: DetailsUseCaseType {
    private let repository: DetailsRepositoryType
    
    init(repository: DetailsRepositoryType) {
        self.repository = repository
    }
    
    func fetchDetails(url: URL, page: Int, category: Category.T) -> AnyPublisher<Result<[Detailable], Error>, Never>{
        repository
            .fetchDetails()
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<[Detailable], Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    func fetchImage(for detail: Detailable) -> AnyPublisher<UIImage?, Never> {
        .just(UIImage(named: "test"))
    }
}

//enum UseCaseError: LocalizedError {
//    case unknownType
//
//    var description: String? {
//        switch self {
//        case .unknownType:            return "Unknown type"
//        }
//    }
//}
////
//final class MainUseCase: MainUseCaseType {
//    private let repository = DefaultNetworkService()
//    private let imageLoaderService = ImageLoaderService()
//
//    public func loadCategories() -> AnyPublisher<Result<[Category], Error>, Never> {
//        repository
//            .load(Resource<Categories>.categories())
//            .map { .success($0.items) }
//            .catch { error -> AnyPublisher<Result<[Category], Error>, Never> in .just(.failure(error)) }
//            .subscribe(on: Scheduler.backgroundWorkScheduler)
//            .receive(on: Scheduler.mainScheduler)
//            .eraseToAnyPublisher()
//    }
//
//    public func loadDetails(url: URL, page: Int, category: Category.T) -> AnyPublisher<Result<[Detailable], Error>, Never> {
//        switch category {
//        case .film:
//            return loadDetails(url: url, page: page, type: Film.self)
//        case .people:
//            return loadDetails(url: url, page: page, type: Сharacter.self)
//        case .planet:
//            return loadDetails(url: url, page: page, type: Planet.self)
//        case .species:
//            return loadDetails(url: url, page: page, type: Species.self)
//        case .starship:
//            return loadDetails(url: url, page: page, type: Starship.self)
//        case .vehicle:
//            return loadDetails(url: url, page: page, type: Vehicle.self)
//        case .unknown:
//            return .just(.failure(UseCaseError.unknownType))
//        }
//    }
//
//    private func loadDetails<T: Detailable>(url: URL, page: Int, type: T.Type) -> AnyPublisher<Result<[Detailable], Error>, Never> {
//        repository
//            .load(Resource<Categories>.categories())
//            .map { _ in return .success([Film]()) }
//
//            //.load(Resource<Details<T>>.details(for: url, page: page, type: type))
//            //.map { .success($0.items) }
//            .catch { error -> AnyPublisher<Result<[Detailable], Error>, Never> in .just(.failure(error)) }
//            .subscribe(on: Scheduler.backgroundWorkScheduler)
//            .receive(on: Scheduler.mainScheduler)
//            .eraseToAnyPublisher()
//    }
//
//    public func loadImage(for detail: Detailable) -> AnyPublisher<UIImage?, Never> {
//        return Deferred { return Just(detail.bucketImagePath) }
//            .flatMap({ [unowned self] path  -> AnyPublisher<UIImage?, Never> in
//                return self.imageLoaderService.loadImage(for: path)
//            })
//            .subscribe(on: Scheduler.backgroundWorkScheduler)
//            .receive(on: Scheduler.mainScheduler)
//            .share()
//            .eraseToAnyPublisher()
//    }
//}
