//
//  MainUseCase.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 03.04.2022.
//

import UIKit
import Combine

final class MainUseCase: MainUseCaseType {
    private let repositoryService: RepositoryServiceType
    private let imageLoaderService: ImageLoaderServiceType
    
    init(repositoryService: RepositoryServiceType, imageLoaderService: ImageLoaderServiceType) {
        self.repositoryService = repositoryService
        self.imageLoaderService = imageLoaderService
    }
    
    public func loadCategories() -> AnyPublisher<Result<[Category], Error>, Never> {
        repositoryService
            .loadCategories()
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<[Category], Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    public func loadDetails(url: URL, page: Int, category: Category.T) -> AnyPublisher<Result<[Detailable], Error>, Never> {
        switch category {
        case .film:
            return loadDetails(url: url, page: page, type: Film.self)
        case .people:
            return loadDetails(url: url, page: page, type: Сharacter.self)
        case .planet:
            return loadDetails(url: url, page: page, type: Planet.self)
        case .species:
            return loadDetails(url: url, page: page, type: Species.self)
        case .starship:
            return loadDetails(url: url, page: page, type: Starship.self)
        case .vehicle:
            return loadDetails(url: url, page: page, type: Vehicle.self)
        case .unknown:
            return .just(.failure(UseCaseError.unknownType))
        }
    }

    private func loadDetails<T: Detailable>(url: URL, page: Int, type: T.Type) -> AnyPublisher<Result<[Detailable], Error>, Never> {
        repositoryService
        
            .loadCategories()
            .map { _ in return .success([Film]()) }
        
            //.load(Resource<Details<T>>.details(for: url, page: page, type: type))
            //.map { .success($0.items) }
            .catch { error -> AnyPublisher<Result<[Detailable], Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    public func loadImage(for detail: Detailable) -> AnyPublisher<UIImage?, Never> {
        return Deferred { return Just(detail.bucketImagePath) }
            .flatMap({ [unowned self] path  -> AnyPublisher<UIImage?, Never> in
                return self.imageLoaderService.loadImage(for: path)
            })
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .share()
            .eraseToAnyPublisher()
    }
}
