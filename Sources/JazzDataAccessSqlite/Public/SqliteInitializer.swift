import JazzCodec
import JazzCore;
import JazzConfiguration;

public final class SqliteInitializer: Initializer {
    public required init() {}

    public override final func initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = configurationBuilder
            .with(file: "Settings/sqlite.config.json", for: SqliteRepositoryConfigV1JsonCodec.supportedMediaType)
            .with(decoder: SqliteRepositoryConfigV1JsonCodec());
    }
}