import JazzDataAccess;

internal class PageHintHandler<TResource: Storable>: BaseHintHandler<TResource, SqliteQuery<TResource>, PageHint> {
    internal override init() {
        super.init();
    }

    public override final func process(for query: SqliteQuery<TResource>, with hint: PageHint) {
        query
            .getBuilder()
            //.limit(hint.getSize())
            //.offset(hint.getSize() * hint.getPage());
    }
}