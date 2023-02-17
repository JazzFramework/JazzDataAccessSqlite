import SQLKit;

import JazzDataAccess;

open class SqliteRepositoryDelegate<TResource: Storable> {
    public init() {}

    open func getTableName() -> String { return ""; }

    open func toSqlUpdate(_ model: TResource, into queryBuilder: SQLUpdateBuilder) { }

    open func toSqlInsert(_ model: TResource, into queryBuilder: SQLInsertBuilder) { }

    open func fromSql(_ row: SQLRow) -> TResource? { return nil; }
}