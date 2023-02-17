import JazzDataAccess;

internal class MaxResultsHintHandler<TResource: Storable>: BaseHintHandler<TResource, SqliteQuery<TResource>, MaxResultsHint> {
    internal override init() {
        super.init();
    }

    public override final func process(for query: SqliteQuery<TResource>, with hint: MaxResultsHint) {
        query
            .getBuilder()
            ;//.limit(hint.getCount());
    }
}