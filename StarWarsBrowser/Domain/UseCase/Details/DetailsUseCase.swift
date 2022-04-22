//
//  MainUseCase.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 03.04.2022.
//

import UIKit
import Combine

final class DetailsUseCase: DetailsUseCaseType {
    let repository: DetailsRepositoryType
    let imagesRepository: DetailImagesRepositoryType
    
    init(repository: DetailsRepositoryType, imagesRepository: DetailImagesRepositoryType) {
        self.repository = repository
        self.imagesRepository = imagesRepository
    }
    
    func loadDetails(url: URL, page: Int, category: Category.T) -> AnyPublisher<Result<[Detailable], Error>, Never> {
        fetch(url: url, page: page, category: category)
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<[Detailable], Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    private func fetch(url: URL, page: Int, category: Category.T) -> AnyPublisher<[Detailable], Error> {
        switch category {
            case .films:
                return repository.fetchFilms(url: url, page: page)
            default:
                return repository.fetchDefaultDetails(url: url, page: page)
        }
    }
    
    func loadImage(for detail: Detailable, category: Category.T) -> AnyPublisher<UIImage?, Never> {
        imagesRepository
            .loadImage(for: detail, category: category)
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .share()
            .eraseToAnyPublisher()
    }
}
