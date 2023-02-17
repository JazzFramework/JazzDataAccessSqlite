import JazzDataAccess;

internal final class IdsQueryCriterionHandler<TResource: Storable>: BaseCriterionHandler<TResource, SqliteQuery<TResource>, IdsQueryCriterion> {
    internal override init() {
        super.init();
    }

    public override final func process(for query: SqliteQuery<TResource>, with criterion: IdsQueryCriterion) {
        query
            .getBuilder()
            .where("id", .in, criterion.getIds());
    }
}