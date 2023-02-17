import JazzDataAccess;

internal final class IdQueryCriterionHandler<TResource: Storable>: BaseCriterionHandler<TResource, SqliteQuery<TResource>, IdQueryCriterion> {
    internal override init() {
        super.init();
    }

    public override final func process(for query: SqliteQuery<TResource>, with criterion: IdQueryCriterion) {
        query
            .getBuilder()
            .where("id", .equal, criterion.getId());
    }
}