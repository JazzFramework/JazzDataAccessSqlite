import Foundation;

import SQLKit;

import JazzDataAccess;

internal final class SqliteRepository<TResource: Storable>: Repository<TResource> {
    private let database: SQLDatabase;
    private let delegate: SqliteRepositoryDelegate<TResource>;
    private let criterionProcessor: CriterionProcessor<TResource>;
    private let hintProcessor: HintProcessor<TResource>;

    internal init(
        database: SQLDatabase,
        delegate: SqliteRepositoryDelegate<TResource>,
        criterionProcessor: CriterionProcessor<TResource>,
        hintProcessor: HintProcessor<TResource>
    ) {
        self.database = database;
        self.delegate = delegate;
        self.criterionProcessor = criterionProcessor;
        self.hintProcessor = hintProcessor;

        super.init();
    }
/*
    public final override func open() async throws {}

    public final override func close() async throws {}
*/
    public final override func create(_ models: [TResource], with hints: [QueryHint]) async throws -> [TResource] {
        for model in models {
            let queryBuilder: SQLInsertBuilder = database.insert(into: delegate.getTableName());

            delegate.toSqlInsert(model, into: queryBuilder);

            try await queryBuilder.run().get();
        }

        return models;
    }

    public final override func update(_ models: [TResource], with hints: [QueryHint]) async throws -> [TResource] {
        for model in models {
            let queryBuilder: SQLUpdateBuilder = database.update(delegate.getTableName()).where("id", .equal, model.getId());

            delegate.toSqlUpdate(model, into: queryBuilder);

            try await queryBuilder.run().get();
        }

        return models;
    }

    public final override func delete(for criteria: [QueryCriterion], with hints: [QueryHint]) async throws {
        let queryBuilder: SQLDeleteBuilder = database.delete(from: delegate.getTableName());

        let query: SqliteQuery<TResource> = SqliteQuery<TResource>(queryBuilder);

        try criterionProcessor.handle(for: query, with: criteria);

        try hintProcessor.handle(for: query, with: hints);

        _ = try await queryBuilder.run().get();
    }

    public final override func get(for criteria: [QueryCriterion], with hints: [QueryHint]) async throws -> PaginationResult<TResource> {
        let queryBuilder: SQLSelectBuilder = database.select().column("*").from(delegate.getTableName());

        let query: SqliteQuery<TResource> = SqliteQuery<TResource>(queryBuilder);

        try criterionProcessor.handle(for: query, with: criteria);

        try hintProcessor.handle(for: query, with: hints);

        let results: [SQLRow] = try await queryBuilder.all().get();

        var modelResults: [TResource] = [];

        for result in results {
            if let resource = delegate.fromSql(result) {
                modelResults.append(resource);
            }
        }

        return PaginationResult(data: modelResults, page: getPageNumber(for: criteria), total: getTotal(for: criteria));
    }

    private final func getPageNumber(for criteria: [QueryCriterion]) -> Int {
        return 0;
    }

    private final func getTotal(for criteria: [QueryCriterion]) -> Int {
        return 0;
    }
}