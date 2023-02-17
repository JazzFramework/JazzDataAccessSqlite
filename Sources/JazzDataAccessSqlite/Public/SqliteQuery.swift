import SQLKit;

import JazzDataAccess;

public final class SqliteQuery<TResource: Storable>: Query<TResource> {
    private let queryBuilder: SQLPredicateBuilder;

    internal init(_ queryBuilder: SQLPredicateBuilder) {
        self.queryBuilder = queryBuilder;

        super.init();
    }

    public final func getBuilder() -> SQLPredicateBuilder {
        return queryBuilder;
    }
}