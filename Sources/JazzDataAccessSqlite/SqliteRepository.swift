import Foundation;

import JazzDataAccess;

public final class SqliteRepository<TResource: Storable>: Repository<TResource> {
    private let criterionProcessor: CriterionProcessor<TResource>;
    private let hintProcessor: HintProcessor<TResource>;

    public init(criterionProcessor: CriterionProcessor<TResource>, hintProcessor: HintProcessor<TResource>) {        
        self.criterionProcessor = criterionProcessor;
        self.hintProcessor = hintProcessor;

        super.init();
    }

    public final override func open() async throws {}

    public final override func close() async throws {}

    public final override func create(_ models: [TResource], with hints: [QueryHint]) async throws -> [TResource] {
        return models;
    }

    public final override func update(_ models: [TResource], with hints: [QueryHint]) async throws -> [TResource] {
        return models;
    }

    public final override func delete(for criteria: [QueryCriterion], with hints: [QueryHint]) async throws {}

    public final override func get(for criteria: [QueryCriterion], with hints: [QueryHint]) async throws -> [TResource] {
        return [];
    }
}